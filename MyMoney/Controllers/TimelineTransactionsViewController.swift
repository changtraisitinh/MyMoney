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

    var days:[String] = []
    
    var data = [Int: [(TimelinePoint, UIColor, String, String, String?, [String]?, String?)]]()
    
    var db:DBHelper = DBHelper()
    
    var transactions:[Transaction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Config Float Action Button
        layoutFAB()
//        floaty.sticky = true // sticking to parent
//        floaty.addDragging()
        
        // Config Table View
        tableView.tableFooterView = UIView(frame: .zero)
        
        let bundle = Bundle(for: TimelineTableViewCell.self)
        let nibUrl = bundle.url(forResource: "TimelineTableViewCell", withExtension: "bundle")
        let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell",
            bundle: Bundle(url: nibUrl!)!)
        tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")
        
        
        // Load data to binding table view
        loadTransactions()
        
        // Show image no transactions when table view no data
        if(days.count == 0) {
            let imgNoTransaction = UIImage(named: "019-cloud")
            let imageViewNoTransaction = UIImageView(image: imgNoTransaction!)
            imageViewNoTransaction.center = self.view.center
            view.addSubview(imageViewNoTransaction)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        NSLog("viewDidAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        NSLog("viewDidDisappear")
    }
    
    // MARK: - Table View Data Source

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
      
      floaty.hasShadow = true
      floaty.addItem("Add transaction", icon: UIImage(named: "028-bank")) { item in
        
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "navAddTransactions") as! UINavigationController
        self.present(vc, animated: true, completion: nil)
      }
      floaty.addItem("Share your transactions ", icon: UIImage(named: "022-finger"))
      floaty.addItem("Save to file", icon: UIImage(named: "048-archive"))
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
