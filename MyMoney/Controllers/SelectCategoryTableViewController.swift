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
    
    var categoryImages : [UIImage] = [#imageLiteral(resourceName: "walking"),#imageLiteral(resourceName: "poultry"),#imageLiteral(resourceName: "eating"),#imageLiteral(resourceName: "house"),#imageLiteral(resourceName: "sailing"),#imageLiteral(resourceName: "walking"),#imageLiteral(resourceName: "poultry"),#imageLiteral(resourceName: "eating"),#imageLiteral(resourceName: "house"),#imageLiteral(resourceName: "walking"),#imageLiteral(resourceName: "poultry"),#imageLiteral(resourceName: "eating"),#imageLiteral(resourceName: "house"),#imageLiteral(resourceName: "walking"),#imageLiteral(resourceName: "poultry"),#imageLiteral(resourceName: "eating"),#imageLiteral(resourceName: "house")]
    
    
    // These strings will be the data for the table view cells
//    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    
    // These are the colors of the square views in our table view cells.
    // In a real project you might use UIImages.
//    let colors = [UIColor.blue, UIColor.yellow, UIColor.magenta, UIColor.red, UIColor.brown]

    // Don't forget to enter this in IB also
    let cellReuseIdentifier = "cell"
    
    //For get categories list from sqlite
    var db:DBHelper = DBHelper()
    
    var categories:[Category] = []
    var categorySelected: Category? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLog(">>>>> SelectCategoryTableViewController")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.delegate = self
        tableView.dataSource = self
        
        categories = db.getCategories()
        
        
        // Insert data testing
        db.insertCategory(id: 1, name: "Foods", icon: "049-business and finance")
        db.insertCategory(id: 2, name: "Transport", icon: "030-bill")
        db.insertCategory(id: 3, name: "Shopping", icon: "035-bank")
        db.insertCategory(id: 4, name: "Other", icon: "038-business")
        
        for (index, category) in categories.enumerated() {
            print(index, ":", category)
//            categories.append(Category(id: category.id, name: category.name, icon: category.icon))
            
        }
        
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return animals.count
//    }
//    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return animals.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CategoryCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CategoryCell

//        NSLog(String(indexPath.row))
//        cell.imageViewCategory.image = UIImage(named: "016-bill")
        
//        cell.labelCategory.text = self.animals[indexPath.row]
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}

