//
//  Int+DotFormatted.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 23/6/23.
//

import Foundation

extension Int {
    func dotFormatted() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = "."
        return formatter.string(from: NSNumber(value:self))!
    }
}
