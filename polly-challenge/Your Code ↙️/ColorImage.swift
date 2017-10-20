//
//  ColorImage.swift
//  polly-challenge
//
//  Created by Robert Cantoni on 10/19/17.
//  Copyright © 2017 Polly Inc. All rights reserved.
//

import UIKit

extension UIImage {

    func polly_image(withColor color: UIColor) -> UIImage {
        let frame = CGRect(origin: .zero, size: size)

        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext();
        self.draw(in: frame)
        context!.setFillColor(color.cgColor);
        context!.setBlendMode(.sourceAtop)
        context!.fill(frame)
        let colorizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();

        return colorizedImage!
    }
}
