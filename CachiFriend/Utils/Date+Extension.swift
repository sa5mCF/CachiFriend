//
//  Date+Extention.swift
//  CachiFriend
//
//  Created by Samuel Chavez on 29/03/26.
//

import Foundation

extension Date {
    func showText() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
    }
}
