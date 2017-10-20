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

class FriendCollectionViewCell: UICollectionViewCell {

    let avatarImageView = UIImageView()
    let nameLabel = UILabel()
    let phoneNumberLabel = UILabel()
    let namePhoneStackView = UIStackView()
    let button = UIButton()
    let hairline = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = UIColor.white

        contentView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(contentView).offset(16.0)
            make.centerY.equalTo(contentView)
            make.height.equalTo(35.0)
            make.width.equalTo(35.0)
        }

        button.titleLabel?.font = PollyFonts.semiBold.font(withSize: 14.0)
        button.imageEdgeInsets = UIEdgeInsetsMake(0.0, -2.0, 0.0, 2.0)
        button.layer.cornerRadius = 16.0
        button.clipsToBounds = true
        contentView.addSubview(button)
        button.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(contentView.snp.trailing).offset(-8.0)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(60.0)
            make.height.equalTo(32.0)
        }

        let hairlineHeight: CGFloat = 1.0 / UIScreen.main.scale
        let hairlineColor = UIColor(red: 204/255, green: 214/255, blue: 221/255, alpha: 1.0)
        hairline.backgroundColor = hairlineColor
        contentView.addSubview(hairline)
        hairline.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)
            make.height.equalTo(hairlineHeight)
        }

        nameLabel.font = PollyFonts.semiBold.font(withSize: 20.0)
        nameLabel.textColor = UIColor(red: 78/255, green: 72/255, blue: 104/255, alpha: 1.0)
        phoneNumberLabel.font = PollyFonts.semiBold.font(withSize: 12.0)
        phoneNumberLabel.textColor = UIColor(red: 190/255, green: 196/255, blue: 200/255, alpha: 1.0)

        namePhoneStackView.addArrangedSubview(nameLabel)
        namePhoneStackView.addArrangedSubview(phoneNumberLabel)
        namePhoneStackView.axis = .vertical
        namePhoneStackView.spacing = 4.0
        contentView.addSubview(namePhoneStackView)
        namePhoneStackView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16.0)
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(button.snp.leading).offset(16.0)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        avatarImageView.image = nil
        nameLabel.text = ""

        super.prepareForReuse()
    }

    func configure(user: PLYUser, friendType: FriendType) {
        if let avatar = user.avatar {
            avatarImageView.image = avatar
        }

        if let firstName = user.firstName, let lastName = user.lastName {
            nameLabel.text = firstName + " " + lastName
        }

        if friendType == .QuickAdd {
            phoneNumberLabel.isHidden = true
        } else {
            phoneNumberLabel.isHidden = false
            phoneNumberLabel.text = user.phoneNumber
        }

        configureButtonForType(friendType: friendType)
    }

    private func configureButtonForType(friendType: FriendType) {
        let buttonImage = UIImage(named: "AddIcon")

        if friendType == .QuickAdd {
            button.setTitle("Add", for: .normal)
            button.backgroundColor = UIColor(red: 14/255, green: 173/255, blue: 255/255, alpha: 1.0)
            button.setTitleColor(UIColor.white, for: .normal)
            button.layer.borderWidth = 0.0
            button.setImage(buttonImage, for: .normal)
        } else {
            button.setTitle("Invite", for: .normal)
            button.backgroundColor = UIColor.white
            let inviteColor = UIColor(red: 190/255, green: 196/255, blue: 200/255, alpha: 1.0)
            button.setTitleColor(inviteColor, for: .normal)
            button.layer.borderColor = inviteColor.cgColor
            button.layer.borderWidth = 1.0
            button.setImage(buttonImage?.polly_image(withColor: inviteColor), for: .normal)
        }
    }
}
