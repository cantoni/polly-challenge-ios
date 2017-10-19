//
//  FriendCollectionViewCell.swift
//  polly-challenge
//
//  Created by Robert Cantoni on 10/19/17.
//  Copyright © 2017 Polly Inc. All rights reserved.
//

import UIKit

enum FriendType {
    case QuickAdd, Contacts
}

var avatar: UIImage?
var firstName: String?
var lastName: String?
var phoneNumber: String?
var user: PLYUser?

var avatarImageView: UIImageView?
var nameLabel: UILabel?
var phoneNumberLabel: UILabel?
var button: UIButton?

class FriendCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)

        let myImageView = UIImageView()
        contentView.addSubview(myImageView)
        myImageView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(contentView).offset(16.0)
            make.centerY.equalTo(contentView)
            make.height.equalTo(35.0)
            make.width.equalTo(35.0)
        }

        let myNameLabel = UILabel()
        contentView.addSubview(myNameLabel)
        myNameLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(myImageView.snp.trailing).offset(16.0)
            make.centerY.equalTo(contentView)
            make.height.equalTo(35.0)
            make.width.equalTo(70.0)
        }

        let myPhoneNumberLabel = UILabel()
        let myButton = UIButton()

        // we'll want references to these later
        avatarImageView = myImageView
        nameLabel = myNameLabel
        phoneNumberLabel = myPhoneNumberLabel
        button = myButton
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func configure(user: PLYUser, type: FriendType) {

        if type == .QuickAdd {
            contentView.backgroundColor = UIColor.purple
        } else {
            contentView.backgroundColor = UIColor.darkGray
        }
        nameLabel?.text = "Hello world"
        avatarImageView?.image = UIImage(named: "Amy")


    }

    private func configure(avatar: UIImage?, firstName: String?, lastName: String?, phoneNumber: String?) {

    }

}





















