//
//  AddingTimeInterval.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 14/01/2022.
//

import Foundation

extension Date {
    var calendar: Calendar {
        Calendar.current
    }
    
    func adding(_ component: Calendar.Component, value: Int) -> Date? {
        return calendar.date(byAdding: component, value: value, to: self)
    }
}
