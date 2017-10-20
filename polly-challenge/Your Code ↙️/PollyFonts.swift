//
//  PollyFonts.swift
//  polly-challenge
//
//  Created by Robert Cantoni on 10/19/17.
//  Copyright © 2017 Polly Inc. All rights reserved.
//

import UIKit

enum PollyFonts: String {
    case semiBold = "ProximaNova-Semibold"

    func font(withSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: rawValue, size: size) else {
            #if CONFIGURATION_Debug
                fatalError("Font with name \(rawValue) and size \(size) could not be created")
            #else
                print("Font could not be created, falling back")
                return UIFont.systemFont(ofSize: size)
            #endif
        }

        return font
    }
}
