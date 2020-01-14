//
//  TimelineTableTableViewController.swift
//  MyMoney
//
//  Created by Admin on 09/01/2020.
//  Copyright © 2020 changtraisitinh. All rights reserved.
//

import UIKit
import TimelineTableViewCell
import Floaty

class TimelineTransactionsViewController: UITableViewController, FloatyDelegate {
    
    var floaty = Floaty()

    // let days:[String] = ["01/01/2020", "23/02/2020"]
    var days:[String] = []
    
    // TimelinePoint, Timeline back color, title, description, lineInfo, thumbnails, illustration
//    var data:[Int: [(TimelinePoint, UIColor, String, String, String?, [String]?, String?)]] = [:]
    var data = [Int: [(TimelinePoint, UIColor, String, String, String?, [String]?, String?)]]()
    
//    let data:[Int: [(TimelinePoint, UIColor, String, String, String?, [String]?, String?)]] = [0:[
//            (TimelinePoint(), UIColor.lightGray, "27.000 đ", "Ăn trưa.", "Foods", nil, "Sun"),
//            (TimelinePoint(), UIColor.lightGray, "50.000 đ", "Đổ xăng.", "Transportion", nil, "Sun"),
//            (TimelinePoint(color: UIColor.lightGray, filled: true), UIColor.lightGray, "30.000 đ", "Ăn trưa.", "Foods", ["Apple"], "Sun"),
//            (TimelinePoint(), UIColor.lightGray, "100.000 đ", "Mua card điện thoại.", "Others", nil, "Moon")
//        ], 1:[
//            (TimelinePoint(), UIColor.lightGray, "27.000 đ", "Ăn trưa.", "Foods", nil, "Sun"),
//            (TimelinePoint(), UIColor.lightGray, "50.000 đ", "Đổ xăng.", "Transportion", nil, "Sun"),
//            (TimelinePoint(color: UIColor.lightGray, filled: true), UIColor.lightGray, "30.000 đ", "Ăn trưa.", "Foods", ["Apple"], "Sun"),
//            (TimelinePoint(), UIColor.lightGray, "100.000 đ", "Mua card điện thoại.", "Others", nil, "Moon"),
//            (TimelinePoint(), UIColor.lightGray, "27.000 đ", "Ăn trưa.", "Foods", nil, "Sun"),
//            (TimelinePoint(), UIColor.lightGray, "50.000 đ", "Đổ xăng.", "Transportion", nil, "Sun"),
//            (TimelinePoint(color: UIColor.lightGray, filled: true), UIColor.lightGray, "30.000 đ", "Ăn trưa.", "Foods", ["Apple"], "Sun"),
//            (TimelinePoint(), UIColor.lightGray, "100.000 đ", "Mua card điện thoại.", "Others", nil, "Moon"),
//            (TimelinePoint(), UIColor.lightGray, "27.000 đ", "Ăn trưa.", "Foods", nil, "Sun"),
//            (TimelinePoint(), UIColor.lightGray, "50.000 đ", "Đổ xăng.", "Transportion", nil, "Sun"),
//            (TimelinePoint(color: UIColor.lightGray, filled: true), UIColor.lightGray, "30.000 đ", "Ăn trưa.", "Foods", ["Apple"], "Sun"),
//            (TimelinePoint(), UIColor.lightGray, "100.000 đ", "Mua card điện thoại.", "Others", nil, "Moon")
//        ]]
    
    var db:DBHelper = DBHelper()
    
    var transactions:[Transaction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        data = [0:[(TimelinePoint(), UIColor.lightGray, "27.000 đ", "Ăn trưa.", "Foods", nil, "Sun"),
//                    (TimelinePoint(), UIColor.lightGray, "50.000 đ", "Đổ xăng.", "Transportion", nil, "Sun"),
//                    (TimelinePoint(color: UIColor.lightGray, filled: true), UIColor.lightGray, "30.000 đ", "Ăn trưa.", "Foods", ["Apple"], "Sun"),
//                    (TimelinePoint(), UIColor.lightGray, "100.000 đ", "Mua card điện thoại.", "Others", nil, "Moon")
//                ]]
        
        
        loadTransactions()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
//        let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell", bundle: Bundle(for: TimelineTableViewCell.self))
//        self.tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")
        
        let bundle = Bundle(for: TimelineTableViewCell.self)
        let nibUrl = bundle.url(forResource: "TimelineTableViewCell", withExtension: "bundle")
        let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell",
            bundle: Bundle(url: nibUrl!)!)
        tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")
        
        floaty.sticky = true // sticking to parent UIScrollView(also UITableView, UICollectionView)
        layoutFAB()
//        floaty.addDragging()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        NSLog("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        NSLog("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        NSLog("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        NSLog("viewDidDisappear")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let sectionData = data[section] else {
            return 0
        }
        return sectionData.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return days[section]
     }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell", for: indexPath) as! TimelineTableViewCell

         // Configure the cell...
         guard let sectionData = data[indexPath.section] else {
             return cell
         }
         
         let (timelinePoint, timelineBackColor, title, description, lineInfo, thumbnails, illustration) = sectionData[indexPath.row]
         var timelineFrontColor = UIColor.clear
         if (indexPath.row > 0) {
             timelineFrontColor = sectionData[indexPath.row - 1].1
         }
         cell.timelinePoint = timelinePoint
         cell.timeline.frontColor = timelineFrontColor
         cell.timeline.backColor = timelineBackColor
         cell.titleLabel.text = title
         cell.descriptionLabel.text = description
         cell.lineInfoLabel.text = lineInfo
         
         if let thumbnails = thumbnails {
             cell.viewsInStackView = thumbnails.map { thumbnail in
                 return UIImageView(image: UIImage(named: thumbnail))
             }
         }
         else {
             cell.viewsInStackView = []
         }

         if let illustration = illustration {
             cell.illustrationImageView.image = UIImage(named: illustration)
         }
         else {
             cell.illustrationImageView.image = nil
         }
    
         return cell
     }
     
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         guard let sectionData = data[indexPath.section] else {
             return
         }
         
         print(sectionData[indexPath.row])
     }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    
    
    // MARK: - Floaty Layouts
    func layoutFAB() {
      let item = FloatyItem()
      item.hasShadow = false
      item.buttonColor = UIColor.blue
      item.circleShadowColor = UIColor.red
      item.titleShadowColor = UIColor.blue
      item.titleLabelPosition = .right
      item.title = ""
      item.handler = { item in
        
      }
      
      floaty.hasShadow = false
//      floaty.addItem(title: "I got a title")
//      floaty.addItem("", icon: UIImage(named: "icShare"))
      floaty.addItem("Add transaction", icon: UIImage(named: "icMap")) { item in
//        let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Me too", style: .default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
        
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "navAddTransactions") as! UINavigationController
        self.present(vc, animated: true, completion: nil)
      }
//      floaty.addItem(item: item)
//      floaty.paddingX = self.view.frame.width/2 - floaty.frame.width/2
      floaty.paddingX = self.view.frame.width/2 - floaty.frame.width*3
      floaty.paddingY = 150
      floaty.fabDelegate = self
      
      self.view.addSubview(floaty)
      
    }
    
    // MARK: - Floaty Delegate Methods
    func floatyWillOpen(_ floaty: Floaty) {
      print("Floaty Will Open")
    }
    
    func floatyDidOpen(_ floaty: Floaty) {
      print("Floaty Did Open")
    }
    
    func floatyWillClose(_ floaty: Floaty) {
      print("Floaty Will Close")
    }
    
    func floatyDidClose(_ floaty: Floaty) {
      print("Floaty Did Close")
    }
    
    @IBAction func unwindToTimelineTransactionsView(segue:UIStoryboardSegue) {
        NSLog("unwindToTimelineTransactionsView")
        
        loadTransactions()
        tableView.reloadData()
    }
    
    // MARK: - Custom Functions
    func loadTransactions() {
//        db.insertTransaction(id: 1, categoryId: 1, amount: 100000, date: "11/01/2020", description: "")
//        db.insertTransaction(id: 2, categoryId: 2, amount: 200000, date: "12/01/2020", description: "")
//        db.insertTransaction(id: 3, categoryId: 2, amount: 200000, date: "13/01/2020", description: "")
//        db.insertTransaction(id: 4, categoryId: 3, amount: 300000, date: "14/01/2020", description: "")
        
        transactions = db.getTransactions()
        
        days = db.getTransactionsGroupByDay()
        
        for (index, day) in days.enumerated() {
            
            var timelineObject = [(TimelinePoint, UIColor, String, String, String?, [String]?, String?)]()
            for (index, transaction) in transactions.enumerated() {
                
                if (day == transaction.date) {
                    let category = db.getCategoriesById(categoryId: transaction.categoryId)
                    
                    timelineObject.append((TimelinePoint(), UIColor.darkGray, String(transaction.amount), String(transaction.description), category.name, [], category.icon))
                }
                
                
            }
            
            data[index] = timelineObject
        }
    }
}
