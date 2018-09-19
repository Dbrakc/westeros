//
//  Date.swift
//  Westeros
//
//  Created by David Braga  on 19/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import Foundation
extension Date {
   static func dateWithDay(_ day: Int, month : Int, year: Int )->Date?{
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = 12
        let calendar = Calendar.current
        return calendar.date(from: dateComponents)
    }
}
