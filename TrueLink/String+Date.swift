//
//  String+Date.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/16/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import Foundation
extension String {
    func convertToDate() -> NSDate? {
        let apiDateFormat = "yyyy-MM-dd'T'HH:mm:ss:SSS"
        let dateFor: DateFormatter = DateFormatter()
        dateFor.dateFormat = apiDateFormat
        return dateFor.date(from: self)! as NSDate
    }
}
