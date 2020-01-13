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
    @IBOutlet weak var imageViewCategory: UIImageView!
    @IBAction func btnNavCancel(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)

    }
    
    
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
        
        btnAddCategory.setTitle(categorySelected_name ?? "Select category" ,for: .normal)
        imageViewCategory.image = UIImage(named: categorySelected_icon ?? "027-bills")
        
        NSLog(">>> id: \(categorySelected_id) | name: \(categorySelected_name) | icon: \(categorySelected_icon)")
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
    }

}
