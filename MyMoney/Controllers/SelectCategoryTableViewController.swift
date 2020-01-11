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
    
    var categoryImages : [UIImage] = [#imageLiteral(resourceName: "walking"),#imageLiteral(resourceName: "poultry"),#imageLiteral(resourceName: "eating"),#imageLiteral(resourceName: "house"),#imageLiteral(resourceName: "sailing"),#imageLiteral(resourceName: "walking"),#imageLiteral(resourceName: "poultry"),#imageLiteral(resourceName: "eating"),#imageLiteral(resourceName: "house"),#imageLiteral(resourceName: "walking"),#imageLiteral(resourceName: "poultry"),#imageLiteral(resourceName: "eating"),#imageLiteral(resourceName: "house"),#imageLiteral(resourceName: "walking"),#imageLiteral(resourceName: "poultry"),#imageLiteral(resourceName: "eating"),#imageLiteral(resourceName: "house"),]
    
    // These strings will be the data for the table view cells
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    
    // These are the colors of the square views in our table view cells.
    // In a real project you might use UIImages.
    let colors = [UIColor.blue, UIColor.yellow, UIColor.magenta, UIColor.red, UIColor.brown]

    // Don't forget to enter this in IB also
    let cellReuseIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.delegate = self
        tableView.dataSource = self
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
        return animals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CategoryCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CategoryCell

//        NSLog(String(indexPath.row))
        cell.imageViewCategory?.image! = #imageLiteral(resourceName: "sailing")
        
        cell.labelCategory.text = self.animals[indexPath.row]

        return cell
    }
    
    // method to run when table view cell is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
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
