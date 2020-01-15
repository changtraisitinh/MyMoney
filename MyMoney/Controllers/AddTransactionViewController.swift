//
//  AddTransactionViewController.swift
//  MyMoney
//
//  Created by Admin on 11/01/2020.
//  Copyright © 2020 changtraisitinh. All rights reserved.
//

import UIKit

class AddTransactionViewController: UIViewController {

    @IBOutlet weak var btnAddCategory: UIButton!
    
    @IBOutlet weak var txtAmount: UITextField!
    
    @IBOutlet weak var imageViewCategory: UIImageView!
    
    @IBOutlet weak var txtDescription: UITextField!
    
    @IBAction func btnNavCancel(_ sender: Any) {
         navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)

    }
    
    
    // MARK: - Initial
    var db:DBHelper = DBHelper()
    let categorySelected: Category = Category(id: 0, name: "", icon: "", type: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Save", style: .done, target: self, action: #selector(self.action(sender:)))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let categorySelected_id = UserDefaults.standard.string(forKey: "categorySelected_id")
        let categorySelected_name = UserDefaults.standard.string(forKey: "categorySelected_name")
        let categorySelected_icon = UserDefaults.standard.string(forKey: "categorySelected_icon")
        
        if (categorySelected_id != nil) {
            categorySelected.id = Int(categorySelected_id!)!
            categorySelected.name = categorySelected_name!
            categorySelected.icon = categorySelected_icon!
        }
        
        
        
        btnAddCategory.setTitle(categorySelected_name ?? "Select category" ,for: .normal)
        if(categorySelected_name != nil) {
            imageViewCategory.image = UIImage(named: categorySelected_icon ?? "027-bills")
            
        }

        NSLog(">>> id: \(categorySelected_id) | name: \(categorySelected_name) | icon: \(categorySelected_icon)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NSLog("viewDidDisappear")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func action(sender: UIBarButtonItem) {
        // Function body goes here
        NSLog("Saved ....")
        
        let transactionCount1: Int = db.getTransactions().count
        NSLog(">>> Before: \(transactionCount1)")
        let currentDate:String = Date().string(format: "dd/MM/yyyy")
        NSLog("currentDate: \(currentDate)")
        db.insertTransaction(id: transactionCount1 + 1, categoryId: categorySelected.id, amount: Int(txtAmount.text ?? "0") ?? 0, date: currentDate, description: txtDescription.text!)
        
        
        
        let transactionCount2: Int = db.getTransactions().count
        NSLog(">>> After: \(transactionCount2)")
        
        performSegue(withIdentifier: "unwindToTimelineTransactionsView", sender: self)
        
        dismiss(animated: true, completion: nil)
        
    }

}
