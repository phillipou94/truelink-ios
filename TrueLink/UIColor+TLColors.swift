//
//  UIColor+TLColors.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/15/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

//
//  UIColor+ImpactColors.swift
//  Impact
//
//  Created by Phillip Ou on 8/20/15.
//  Copyright (c) 2015 Impact. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    
    static func TLBlack() -> UIColor {
        return TLBlackWithAlpha(alpha: 1.0)
    }
    
    static func TLOrange() -> UIColor {
        return TLOrangeWithAlpha(alpha: 1.0)
    }
    
    static func TLDarkGrey() -> UIColor {
        return TLDarkGreyWithAlpha(alpha: 1.0)
    }
    
    static func TLLightGrey() -> UIColor {
        return TLLightGreyWithAlpha(alpha: 1.0)
    }
    
    static func TLOffWhite() -> UIColor {
        return TLOffWhiteWithAlpha(alpha: 1.0)
    }
    
    static func TLBlackWithAlpha(alpha:CGFloat) -> UIColor {
        return UIColor(red: 74/255.0, green: 74/255.0, blue: 74/255.0, alpha: alpha);
    }
    
    static func TLOrangeWithAlpha(alpha:CGFloat) -> UIColor {
        return UIColor(red: 242/255.0, green: 107/255.0, blue: 92/255.0, alpha: alpha);
    }
    
    static func TLDarkGreyWithAlpha(alpha:CGFloat) -> UIColor {
        return UIColor(red: 196/255.0, green: 191/255.0, blue: 191/255.0, alpha: alpha);
    }
    
    static func TLLightGreyWithAlpha(alpha:CGFloat) -> UIColor {
        return UIColor(red: 196/255.0, green: 191/255.0, blue: 191/255.0, alpha: alpha);
    }
    
    static func TLOffWhiteWithAlpha(alpha:CGFloat) -> UIColor {
        return UIColor(red: 250/255.0, green: 248/255.0, blue: 248/255.0, alpha: alpha);
    }
    
    static func TLSpecialBlue() -> UIColor {
         return UIColor(red: 55/255.0, green: 71/255.0, blue: 141/255.0, alpha: 1.0)
    }
    
    static func TLSpecialGreen() -> UIColor {
        return UIColor(red: 51/255.0, green: 174/255.0, blue: 139/255.0, alpha: 1.0)
    }

    
}

