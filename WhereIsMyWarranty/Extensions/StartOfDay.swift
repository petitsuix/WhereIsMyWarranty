//
//  StartOfDay.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 18/01/2022.
//

import Foundation

extension Date {

    var startOfDay: Date {
        let calendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([.year, .month, .day])
        let components = calendar.dateComponents(unitFlags, from: self)
        guard let dateFromStart = calendar.date(from: components) else { return self }
        return dateFromStart
   }
}
