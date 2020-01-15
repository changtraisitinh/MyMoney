//
//  AddTransactionsTableViewController.swift
//  MyMoney
//
//  Created by Admin on 10/01/2020.
//  Copyright © 2020 changtraisitinh. All rights reserved.
//

import UIKit

class SelectCategoryTableViewController: UITableViewController {
    
    @IBOutlet var tbView: UITableView!

    // Don't forget to enter this in IB also
    let cellReuseIdentifier = "cell"
    
    //For get categories list from sqlite
    var db:DBHelper = DBHelper()
    
    var categories:[Category] = []
    var categorySelected: Category? = nil
    
    var categoryTypeSelected: String = ECategoryType.EXPENSE.value()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLog(">>> SelectCategoryTableViewController")
        
        // Insert data testing
        saveCategoriesList()
        
        //load categories list from databases
        loadCategories()
                
        // Config Table View
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        
        // Segmented Control EXPENSE & INCOME
        addSegmentedControl()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CategoryCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CategoryCell

        cell.labelCategory.text = categories[indexPath.row].name
        cell.imageViewCategory.image = UIImage(named: categories[indexPath.row].icon)

        return cell
    }
    
    // method to run when table view cell is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        let categorySelected: Category = categories[indexPath.row]
        
        UserDefaults.standard.set(categorySelected.id, forKey: "categorySelected_id")
        UserDefaults.standard.set(categorySelected.name, forKey: "categorySelected_name")
        UserDefaults.standard.set(categorySelected.icon, forKey: "categorySelected_icon")
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadCategories() {
        categories.removeAll()
        categories = db.getCategoriesByType(type: categoryTypeSelected)
        NSLog(">>> categoryTypeSelected: \(categoryTypeSelected)")
        for (index, category) in categories.enumerated() {
            print(index, ":", category.name, ":", category.type)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadCategories()
        
        tableView.reloadData()
    }
    
    // MARK: - Segmented Control
    func addSegmentedControl() {
        let segment: UISegmentedControl = UISegmentedControl(items: ["Expense", "Income"])
        segment.sizeToFit()
        segment.tintColor = UIColor(red:0.99, green:0.00, blue:0.25, alpha:1.00)
        segment.selectedSegmentIndex = 0;
        segment.addTarget(self, action: #selector(segmentControl(_:)), for: .valueChanged)
        self.navigationItem.titleView = segment
    }
    
    @objc func segmentControl(_ segmentedControl: UISegmentedControl) {
        
        NSLog("Selected \(segmentedControl.selectedSegmentIndex)")
        switch (segmentedControl.selectedSegmentIndex) {
          case 0:
             // Expense segment tapped
            categoryTypeSelected = ECategoryType.EXPENSE.value()
            loadCategories()
            
          break
          case 1:
             // Income segment tapped
            categoryTypeSelected = ECategoryType.INCOME.value()
            loadCategories()
          break
          default:
          break
        }

        tableView.reloadData()
    }
    
    // MARK: - Save Category Databases
    func saveCategoriesList() {
        // INCOME Category
        db.insertCategory(id: 1, name: "Food & Beverage", icon: "001-atm", type: "INCOME")
        db.insertCategory(id: 2, name: "Shopping", icon: "002-atm", type: "INCOME")
        db.insertCategory(id: 3, name: "Transportation", icon: "003-bag", type: "INCOME")
        db.insertCategory(id: 4, name: "Family", icon: "004-bank", type: "INCOME")
        db.insertCategory(id: 5, name: "Others", icon: "005-bank", type: "INCOME")
        db.insertCategory(id: 6, name: "Entertainment", icon: "006-bank", type: "INCOME")
        db.insertCategory(id: 7, name: "Friends & Lover", icon: "007-analytics", type: "INCOME")
        db.insertCategory(id: 8, name: "Health & Fitness", icon: "008-bank", type: "INCOME")
        db.insertCategory(id: 9, name: "Travel", icon: "009-avatar", type: "INCOME")
        db.insertCategory(id: 10, name: "Investment", icon: "010-agenda", type: "INCOME")
        db.insertCategory(id: 11, name: "Education", icon: "011-cellphone", type: "INCOME")
        
        // EXPENSE Category
        db.insertCategory(id: 20, name: "Gifts", icon: "020-arrow", type: "EXPENSE")
        db.insertCategory(id: 21, name: "Award", icon: "021-cogwheel", type: "EXPENSE")
        db.insertCategory(id: 22, name: "Interest Money", icon: "022-finger", type: "EXPENSE")
        db.insertCategory(id: 23, name: "Salary", icon: "023-banking", type: "EXPENSE")
        db.insertCategory(id: 24, name: "Selling", icon: "024-business", type: "EXPENSE")
        db.insertCategory(id: 25, name: "Others", icon: "025-arrows", type: "EXPENSE")
        
    }
}

