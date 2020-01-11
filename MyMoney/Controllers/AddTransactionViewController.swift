//
//  AddTransactionViewController.swift
//  MyMoney
//
//  Created by Admin on 11/01/2020.
//  Copyright © 2020 changtraisitinh. All rights reserved.
//

import UIKit

class AddTransactionViewController: UIViewController {

    @IBAction func btnNavCancel(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
