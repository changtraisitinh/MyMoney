//
//  DBHelper.swift
//  MyMoney
//
//  Created by Admin on 13/01/2020.
//  Copyright © 2020 changtraisitinh. All rights reserved.
//

import Foundation
import SQLite3

class DBHelper {
    init() {
        db = openDatabase()
        createTableTransactions()
        createTableCategories()
    }

    let dbPath: String = "mymoney.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    // MARK: - Transactions
    
    func createTableTransactions() {
        let createTableString = "CREATE TABLE IF NOT EXISTS transactions(Id INTEGER PRIMARY KEY,categoryId INTEGER, amount INTEGER, date TEXT, description TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("transactions table created.")
            } else {
                print("transactions table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insertTransaction(id:Int, categoryId:Int, amount:Int, date:String, description:String) {
        let transactions = getTransactions()
        for p in transactions {
            if p.id == id
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO transactions (Id, categoryId, amount, date, description) VALUES (?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_int(insertStatement, 2, Int32(categoryId))
            sqlite3_bind_int(insertStatement, 3, Int32(amount))
            sqlite3_bind_text(insertStatement, 4, (date as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (description as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
                
                let error = String(cString: sqlite3_errmsg(self.db))
                
                NSLog(">>> \(error)")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func getTransactions() -> [Transaction] {
        let queryStatementString = "SELECT * FROM transactions;"
        var queryStatement: OpaquePointer? = nil
        var trans : [Transaction] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let categoryId = sqlite3_column_int(queryStatement, 1)
                let amount = sqlite3_column_int(queryStatement, 2)
                let date = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let description = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                
                trans.append(Transaction(id: Int(id), categoryId: Int(categoryId), amount: Int(amount), date: date, description: description))
//                print("Query Result:")
//                print(">>> \(id) | \(categoryId) | \(amount) | \(date)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return trans
    }
    
    func getTransactionsGroupByDay() -> [String] {
            let queryStatementString = "SELECT DISTINCT date FROM transactions;"
            var queryStatement: OpaquePointer? = nil
            var days : [String] = []
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    let date = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                    
                    days.append(date)
                }
            } else {
                print("SELECT statement could not be prepared")
            }
            sqlite3_finalize(queryStatement)
            return days
        }
    
    func getTransactionsGroupByCategory() -> [TransactionsGroupByCategory] {
        let queryStatementString = "SELECT categoryId, count(1) as quantity FROM transactions GROUP BY categoryId;"
        var queryStatement: OpaquePointer? = nil
        var transactions : [TransactionsGroupByCategory] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let categoryId = sqlite3_column_int(queryStatement, 0)
                let quantity = sqlite3_column_int(queryStatement, 1)
                
                transactions.append(TransactionsGroupByCategory(categoryId: Int(categoryId), quantity: Int(quantity)))
                
//                NSLog(">>> categoryId: \(categoryId) | quantity: \(quantity)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return transactions
    }
    
    func getTransactionsAmountSummary() -> Int32 {
        let queryStatementString = "SELECT SUM(amount) FROM transactions;"
        var queryStatement: OpaquePointer? = nil
        var summary: Int32 = 0
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                summary = sqlite3_column_int(queryStatement, 0)
                
//                NSLog(">>> summary: \(summary)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return summary
    }
    
    func getTransactionsQuantity() -> Int32 {
        let queryStatementString = "SELECT COUNT(1) FROM transactions;"
        var queryStatement: OpaquePointer? = nil
        var summary: Int32 = 0
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                summary = sqlite3_column_int(queryStatement, 0)
                
//                NSLog(">>> summary: \(summary)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return summary
    }
    
    func deleteTransactionByID(id:Int) {
        let deleteStatementStirng = "DELETE FROM transactions WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    // MARK: - Categories
    func createTableCategories() {
        let createTableString = "CREATE TABLE IF NOT EXISTS categories (Id INTEGER PRIMARY KEY, name TEXT, icon TEXT, type TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("categories table created.")
            } else {
                print("categories table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insertCategory(id: Int, name: String, icon: String, type: String) {
        let categories = getCategories()
        for p in categories {
            if p.id == id
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO categories (Id, name, icon, type) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (icon as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (type as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func getCategories() -> [Category] {
        let queryStatementString = "SELECT * FROM categories;"
        var queryStatement: OpaquePointer? = nil
        var categories : [Category] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let icon = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let type = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                
                categories.append(Category(id: Int(id), name: name, icon: icon, type: type))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return categories
    }
    
    func getCategoriesById(categoryId: Int) -> Category {
        let queryStatementString = "SELECT * FROM categories WHERE id = ?;"
        var queryStatement: OpaquePointer? = nil
        var category : Category = Category(id: 0, name: "", icon: "", type: "")
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(categoryId))
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let icon = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let type = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                
                if(categoryId == id) {
                    category = Category(id: Int(id), name: name, icon: icon, type: type)
                    sqlite3_finalize(queryStatement)
                    return category
                }
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return category
    }
}
