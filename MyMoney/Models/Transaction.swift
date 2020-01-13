//
//  Transaction.swift
//  MyMoney
//
//  Created by Admin on 11/01/2020.
//  Copyright © 2020 changtraisitinh. All rights reserved.
//

import UIKit

class Transaction {
    var id : Int
    var categoryId : Int
    var amount : Int
    var date: String

    
    init(id : Int, categoryId: Int, amount: Int, date: String) {
        self.id = id
        self.categoryId = categoryId
        self.amount = amount
        self.date = date
    }
}
