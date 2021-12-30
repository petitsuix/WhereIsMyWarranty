//
//  TruncateDecimals.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 30/12/2021.
//

import Foundation

extension Double {
    // ⬇︎ Allows to format the result
    func shortDigitsIn(_ maxFractionDigits: Int) -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = maxFractionDigits
        return String(formatter.string(from: number) ?? "\(self)")
    }
}
