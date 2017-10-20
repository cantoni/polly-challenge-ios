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

    private let friendCellIdentifier = "friendCellIdentifier"
    private let friendHeaderIdentifier = "friendHeaderIdentifier"
    private let flowLayout = UICollectionViewFlowLayout()
    private var collectionView: UICollectionView?

    //-----------------------------------
    // MARK: - View Lifecycle
    //-----------------------------------

    override func viewDidLoad() {
        // Super
        super.viewDidLoad()

        // Register cell classes
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
//        flowLayout.headerReferenceSize = CGSize(width: cardView.frame.width, height: 60.0)

        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView?.register(FriendCollectionViewCell.self, forCellWithReuseIdentifier: friendCellIdentifier)
        collectionView?.register(FriendCollectionReusableHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: friendHeaderIdentifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self

        collectionView?.backgroundColor = UIColor(red: 237/255, green: 241/255, blue: 242/255, alpha: 1.0)

        if let collection = collectionView {
            cardView.addSubview(collection)

            collection.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(cardView).offset(0)
                make.left.equalTo(cardView).offset(0)
                make.bottom.equalTo(cardView).offset(0)
                make.right.equalTo(cardView).offset(0)
            }
        }
    }

    //-----------------------------------
    // MARK: - Refreshing Data
    //-----------------------------------

    fileprivate func refreshUsers() {

        /* NOTE: On refresh the number of users for each array may change (Simulating real world updates). Make sure to account for this.*/

        // Update users
        usersToAdd = PLYManager.shared.quickAdds()
        usersInContacts = PLYManager.shared.invites()

        print("We're refreshing")

        // Update the view here
        collectionView?.reloadData()
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
            fatalError("Error: cell with identifier not found")
        }

        var friendType = FriendType.QuickAdd
        var user: PLYUser?
        if indexPath.section == 0 {
            user = usersToAdd[indexPath.row]
        } else {
            friendType = FriendType.Contacts
            user = usersInContacts[indexPath.row]
        }

        if let user = user {
            cell.configure(user: user, friendType: friendType)
        }

        if indexPath.row == 0 {
            roundView(view: cell.contentView, corners: [UIRectCorner.topLeft, UIRectCorner.topRight])
        }

        return cell
    }

    func roundView(view: UIView, corners: UIRectCorner) {
        let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 13.0, height: 13.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.cgPath
        view.layer.mask = maskLayer
    }

//    - (void)roundView:(UIView *)view onCorner:(UIRectCorner)rectCorner radius:(float)radius {
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(radius, radius)];
//    CAShapeLayer *maskLayer = [CAShapeLayer new];
//    maskLayer.frame = view.bounds;
//    maskLayer.path = maskPath.CGPath;
//    [view.layer setMask:maskLayer];
//    }

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

        // TODO: hide header if section has no items

        return CGSize(width: cardView.frame.width, height: 48.0)
    }

    //-----------------------------------
    // MARK: - Collection View Delegate
    //-----------------------------------

    //-----------------------------------
    // MARK: - Flow layout delegate
    //-----------------------------------

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: collectionView.frame.width, height: 60.0)
//    }






}
