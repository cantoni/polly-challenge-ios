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

var avatarImageView: UIImageView?
var nameLabel: UILabel?
var phoneNumberLabel: UILabel?
var namePhoneStackView: UIStackView?
var button: UIButton?
var hairline: UIView?

class FriendCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = UIColor.white

        let myImageView = UIImageView()
        contentView.addSubview(myImageView)
        myImageView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(contentView).offset(16.0)
            make.centerY.equalTo(contentView)
            make.height.equalTo(35.0)
            make.width.equalTo(35.0)
        }
        avatarImageView = myImageView

        let myButton = UIButton(type: .custom)
        myButton.titleLabel?.font = PollyFonts.semiBold.font(withSize: 14.0)
        myButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, -2.0, 0.0, 2.0)
        myButton.layer.cornerRadius = 16.0
        myButton.clipsToBounds = true
        contentView.addSubview(myButton)
        myButton.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(contentView.snp.trailing).offset(-8.0)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(60.0)
            make.height.equalTo(32.0)
        }
        button = myButton

        let hairlineHeight: CGFloat = 1.0 / UIScreen.main.scale
        let hairlineColor = UIColor(red: 204/255, green: 214/255, blue: 221/255, alpha: 1.0)
        let myHairline = UIView()
        myHairline.backgroundColor = hairlineColor
        contentView.addSubview(myHairline)
        myHairline.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)
            make.height.equalTo(hairlineHeight)
        }
        hairline = myHairline

        let myNameLabel = UILabel()
        myNameLabel.font = PollyFonts.semiBold.font(withSize: 20.0)
        myNameLabel.textColor = UIColor(red: 78/255, green: 72/255, blue: 104/255, alpha: 1.0)
        nameLabel = myNameLabel

        let myPhoneNumberLabel = UILabel()
        myPhoneNumberLabel.font = PollyFonts.semiBold.font(withSize: 12.0)
        myPhoneNumberLabel.textColor = UIColor(red: 190/255, green: 196/255, blue: 200/255, alpha: 1.0)
        phoneNumberLabel = myPhoneNumberLabel

        let myNamePhoneStackView = UIStackView(arrangedSubviews: [myNameLabel, myPhoneNumberLabel])
        myNamePhoneStackView.axis = .vertical
        myNamePhoneStackView.spacing = 4.0
        contentView.addSubview(myNamePhoneStackView)
        myNamePhoneStackView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(myImageView.snp.trailing).offset(16.0)
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(myButton.snp.leading).offset(16.0)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        avatarImageView?.image = nil
        nameLabel?.text = ""

        super.prepareForReuse()
    }

    func configure(user: PLYUser, friendType: FriendType) {
        if let avatar = user.avatar {
            avatarImageView?.image = avatar
        }

        if let firstName = user.firstName, let lastName = user.lastName {
            nameLabel?.text = firstName + " " + lastName
        }

        if friendType == .QuickAdd {
            phoneNumberLabel?.isHidden = true
        } else {
            phoneNumberLabel?.isHidden = false
            phoneNumberLabel?.text = user.phoneNumber
        }

        configureButtonForType(friendType: friendType)
    }

    private func configureButtonForType(friendType: FriendType) {
        let buttonImage = UIImage(named: "AddIcon")

        if friendType == .QuickAdd {
            button?.setTitle("Add", for: .normal)
            button?.backgroundColor = UIColor(red: 14/255, green: 173/255, blue: 255/255, alpha: 1.0)
            button?.setTitleColor(UIColor.white, for: .normal)
            button?.layer.borderWidth = 0.0
            button?.setImage(buttonImage, for: .normal)
        } else {
            button?.setTitle("Invite", for: .normal)
            button?.backgroundColor = UIColor.white
            let inviteColor = UIColor(red: 190/255, green: 196/255, blue: 200/255, alpha: 1.0)
            button?.setTitleColor(inviteColor, for: .normal)
            button?.layer.borderColor = inviteColor.cgColor
            button?.layer.borderWidth = 1.0
            button?.setImage(buttonImage?.polly_image(withColor: inviteColor), for: .normal)
        }
    }
}
