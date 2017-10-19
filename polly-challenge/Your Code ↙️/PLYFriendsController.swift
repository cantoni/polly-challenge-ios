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
        flowLayout.itemSize = CGSize(width: cardView.frame.width, height: 60.0)

        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView?.register(FriendCollectionViewCell.self, forCellWithReuseIdentifier: friendCellIdentifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self

//        collectionView?.isPrefetchingEnabled = false

        cardView.backgroundColor = UIColor.magenta
        collectionView?.backgroundColor = UIColor.green

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

        var sections: Int = 0
        if (usersToAdd.count > 0) {
            sections += 1
        }
        if (usersInContacts.count > 0) {
            sections += 1
        }
        return sections
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5

        if section == 0 && usersToAdd.count > 0 {
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
        if indexPath.section == 1 {
            friendType = FriendType.Contacts
        }

        // Configure the cell
        let user = PLYUser()
        cell.configure(user: user, type: friendType)

        let bcolor = UIColor( red: 0.2, green: 0.2, blue:0.2, alpha: 0.3 )

        cell.layer.borderColor = bcolor.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 3

        return cell
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
