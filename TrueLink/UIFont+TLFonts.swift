//
//  UIFont+TLFonts.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/15/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    class func TLFontOfSize(size: CGFloat) -> UIFont {
        return UIFont(name: "Abel-Regular", size: size)!
    }

    func preferredFontForTextStyle(style: UIFontTextStyle) -> UIFont {
        switch(style) {
        case UIFontTextStyle.body:
            return UIFont.systemFont(ofSize: 17)
        case UIFontTextStyle.headline:
            return UIFont.systemFont(ofSize: 25)
        default:
            return UIFont.systemFont(ofSize: 17)
        }
    }
}
