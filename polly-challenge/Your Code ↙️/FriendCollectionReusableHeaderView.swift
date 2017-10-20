//
//  FriendCollectionReusableView.swift
//  polly-challenge
//
//  Created by Robert Cantoni on 10/19/17.
//  Copyright © 2017 Polly Inc. All rights reserved.
//

import UIKit

class FriendCollectionReusableHeaderView: UICollectionReusableView {

    var leftHairline: UIView?
    var rightHairline: UIView?
    var titleLabel: UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)

        let titleLabel = UILabel()
        titleLabel.text = "Quick Adds"
        titleLabel.textColor = UIColor(red: 78/255, green: 72/255, blue: 104/255, alpha: 1.0)
        titleLabel.font = PollyFonts.semiBold.font(withSize: 16.0)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
        }
        self.titleLabel = titleLabel

        let hairlineHeight: CGFloat = 1.0 / UIScreen.main.scale
        let hairlineColor = UIColor(red: 204/255, green: 214/255, blue: 221/255, alpha: 1.0)
        let leftHairline = UIView()
        leftHairline.backgroundColor = hairlineColor
        self.addSubview(leftHairline)
        leftHairline.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.snp.leading).offset(8.0)
            make.trailing.equalTo(titleLabel.snp.leading).offset(-8.0)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(hairlineHeight)
        }
        self.leftHairline = leftHairline

        let rightHairline = UIView()
        rightHairline.backgroundColor = hairlineColor
        self.addSubview(rightHairline)
        rightHairline.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(titleLabel.snp.trailing).offset(8.0)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(hairlineHeight)
            make.trailing.equalTo(self.snp.trailing).offset(-8.0)
        }
        self.rightHairline = rightHairline
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(title: String?) {
        titleLabel?.text = title
    }
}
