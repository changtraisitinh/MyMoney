//
//  StringUtils.swift
//  MyMoney
//
//  Created by Admin on 14/01/2020.
//  Copyright © 2020 changtraisitinh. All rights reserved.
//

import Foundation

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
    
func getCurrentDate() -> String {
    return Date().string(format: "dd/MM/yyyy")
}

