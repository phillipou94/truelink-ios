//
//  String+Date.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/16/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import Foundation
extension String {
    func convertToDate() -> NSDate {
        let apiDateFormat = "yyyy-MM-dd'T'HH:mm:SSSZ"
        let dateFor: DateFormatter = DateFormatter()
        dateFor.dateFormat = apiDateFormat
        
        if let date = dateFor.date(from: self) {
            return date as NSDate
        }
        return Date.init() as NSDate
    }
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return self[Range(start ..< end)]
    }
}
