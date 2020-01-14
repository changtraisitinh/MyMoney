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
    var description: String

    
    init(id : Int, categoryId: Int, amount: Int, date: String, description: String) {
        self.id = id
        self.categoryId = categoryId
        self.amount = amount
        self.date = date
        self.description = description
    }
}

class TransactionsGroupByCategory {
    var categoryId : Int
    var quantity : Int
    
    init(categoryId: Int, quantity: Int) {
        self.categoryId = categoryId
        self.quantity = quantity
    }
}

class TransactionsSummary {
    
    var openingBalance: Int
    var endingBalance: Int
    var netIncome: Int
    var income : Int
    var expense : Int
    
    init(openingBalance: Int, endingBalance: Int, netIncome: Int, income : Int, expense : Int) {
        self.openingBalance = openingBalance
        self.endingBalance = endingBalance
        self.netIncome = netIncome
        self.income = income
        self.expense = expense
    }
}
