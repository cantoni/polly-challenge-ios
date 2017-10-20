//
//  PLYFriendsController.swift
//  polly-challenge
//
//  Created by Vicc Alexander on 10/3/17.
//  Copyright © 2017 Polly Inc. All rights reserved.
//

import UIKit
import SnapKit

class PLYFriendsController: PLYController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //-----------------------------------
    // MARK: - Properties
    //-----------------------------------

    fileprivate var usersToAdd: [PLYUser] = []
    fileprivate var usersInContacts: [PLYUser] = []

    private let flowLayout = UICollectionViewFlowLayout()
    private var collectionView: UICollectionView?
    private let refresher = UIRefreshControl()

    private let friendCellIdentifier = "friendCellIdentifier"
    private let friendHeaderIdentifier = "friendHeaderIdentifier"

    //-----------------------------------
    // MARK: - View Lifecycle
    //-----------------------------------

    override func viewDidLoad() {
        // Super
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {

        // Super
        super.viewDidAppear(animated)

        // Refresh users
        refreshUsers()
    }

    //-----------------------------------
    // MARK: - Setup View
    //-----------------------------------

    override func setupUI() {

        // Super
        super.setupUI()

        /*
         NOTE: Instead of adding your subviews to the controller's view, make sure to add them to cardView.
         - i.e. cardView.addSubview(yourView)
         */

        flowLayout.minimumLineSpacing = 0
        flowLayout.itemSize = CGSize(width: cardView.frame.width-32, height: 60.0)

        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView?.register(FriendCollectionViewCell.self, forCellWithReuseIdentifier: friendCellIdentifier)
        collectionView?.register(FriendCollectionReusableHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: friendHeaderIdentifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        cardView.backgroundColor = UIColor(red: 237/255, green: 241/255, blue: 242/255, alpha: 1.0)
        collectionView?.backgroundColor = UIColor.clear

        collectionView?.layer.shadowColor = UIColor.black.cgColor
        collectionView?.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        collectionView?.layer.shadowOpacity = 0.05
        collectionView?.layer.shadowRadius = 10.0

        collectionView?.alwaysBounceVertical = true
        collectionView?.addSubview(refresher)
        refresher.addTarget(self, action: #selector(refreshUsers), for: .valueChanged)

        if let collection = collectionView {
            cardView.addSubview(collection)

            collection.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(cardView.snp.top)
                make.bottom.equalTo(cardView.snp.bottom)
                make.leading.equalTo(cardView.snp.leading)
                make.trailing.equalTo(cardView.snp.trailing)
            }
        }
    }

    //-----------------------------------
    // MARK: - Refreshing Data
    //-----------------------------------

    @objc fileprivate func refreshUsers() {

        /* NOTE: On refresh the number of users for each array may change (Simulating real world updates). Make sure to account for this.*/

        // Update users
        usersToAdd = PLYManager.shared.quickAdds()
        usersInContacts = PLYManager.shared.invites()

        // Update the view here
        collectionView?.reloadData()
        refresher.endRefreshing()
    }

    //-----------------------------------
    // MARK: - Memory Management
    //-----------------------------------

    override func didReceiveMemoryWarning() {

        // Super
        super.didReceiveMemoryWarning()
    }

    //-----------------------------------
    // MARK: - Collection View Data Source
    //-----------------------------------

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return usersToAdd.count
        } else {
            return usersInContacts.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: friendCellIdentifier, for: indexPath) as? FriendCollectionViewCell else {
            fatalError("Error: cell not dequeued properly")
        }

        var friendType = FriendType.QuickAdd
        var user: PLYUser?
        var roundBottomCorners = false

        if indexPath.section == 0 {
            user = usersToAdd[indexPath.row]
            if indexPath.row == usersToAdd.count-1 {
                roundBottomCorners = true
            }
        } else {
            friendType = .Contacts
            user = usersInContacts[indexPath.row]
            if indexPath.row == usersInContacts.count-1 {
                roundBottomCorners = true
            }
        }

        if let user = user {
            cell.configure(user: user, friendType: friendType)
        }

        if roundBottomCorners == true && indexPath.row == 0 {
            roundView(view: cell.contentView, corners: [.topLeft, .topRight, .bottomRight, .bottomLeft])
        } else if indexPath.row == 0 {
            roundView(view: cell.contentView, corners: [.topLeft, .topRight])
        } else if roundBottomCorners == true {
            roundView(view: cell.contentView, corners: [.bottomLeft, .bottomRight])
        } else {
            cell.contentView.layer.mask = nil
        }

        return cell
    }

    func roundView(view: UIView, corners: UIRectCorner) {
        let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 12.0, height: 12.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.cgPath
        view.layer.mask = maskLayer
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: friendHeaderIdentifier, for: indexPath)
        if let myHeader = headerView as? FriendCollectionReusableHeaderView {
            if indexPath.section == 0 {
                myHeader.configure(title: "Quick Adds")
            } else {
                myHeader.configure(title: "In Your Contacts")
            }
        }
        return headerView
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        if (section == 0 && usersToAdd.count == 0) || (section == 1 && usersInContacts.count == 0) {
            return CGSize.zero
        }

        return CGSize(width: cardView.frame.width, height: 48.0)
    }

}
