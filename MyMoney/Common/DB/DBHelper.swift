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
        let createTableString = "CREATE TABLE IF NOT EXISTS transactions(Id INTEGER PRIMARY KEY,categoryId INTEGER, amount INTEGER, date TEXT);"
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
    
    func insertTransaction(id:Int, categoryId:Int, amount:Int, date:String) {
        let transactions = getTransactions()
        for p in transactions {
            if p.id == id
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO transactions (Id, categoryId, amount, date) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_int(insertStatement, 2, Int32(categoryId))
            sqlite3_bind_int(insertStatement, 3, Int32(amount))
            sqlite3_bind_text(insertStatement, 4, (date as NSString).utf8String, -1, nil)
            
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
                
                trans.append(Transaction(id: Int(id), categoryId: Int(categoryId), amount: Int(amount), date: date))
//                print("Query Result:")
//                print(">>> \(id) | \(categoryId) | \(amount) | \(date)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return trans
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
        let createTableString = "CREATE TABLE IF NOT EXISTS categories (Id INTEGER PRIMARY KEY, name TEXT, icon TEXT);"
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
    
    func insertCategory(id: Int, name: String, icon: String) {
        let categories = getCategories()
        for p in categories {
            if p.id == id
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO categories (Id, name, icon) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (icon as NSString).utf8String, -1, nil)
            
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
                
                categories.append(Category(id: Int(id), name: name, icon: icon))
                print("Query Result:")
                print(">>> \(id) | \(name) | \(icon)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return categories
    }
}