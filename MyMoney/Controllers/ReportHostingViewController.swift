//
//  ReportHostingViewController.swift
//  MyMoney
//
//  Created by Admin on 10/01/2020.
//  Copyright © 2020 changtraisitinh. All rights reserved.
//

import UIKit
import SwiftUI
import SunburstDiagram

struct RootView: View {

    @ObservedObject var configurationIncome: SunburstConfiguration
    @ObservedObject var configurationExpense: SunburstConfiguration
    
    @State var netIncome: Int32 = 0
    
    var body: some View {
        AnyView(GeometryReader { geometry -> AnyView in
            return AnyView(
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        VStack(spacing: 0) {
                            Spacer().frame(height: 10)
                            Text("Opening balance   ").foregroundColor(.gray)
                            Text("\(self.netIncome * -1) ₫   ")
                        }
                        Divider()
                        VStack(spacing: 0) {
                            Spacer().frame(height: 10)
                            Text("   Ending balance").foregroundColor(.gray)
                            Text("   \(self.netIncome + 200000) ₫")
                        }
                    }.frame(height: 70)
                    
                    Divider().edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 0) {
                        Spacer().frame(height: 10)
                        Text("Net Income").foregroundColor(.gray)
                        Text("\(self.netIncome) ₫")
                        Spacer().frame(height: 10)
                    }
                    
                    Divider().edgesIgnoringSafeArea(.all)
                    VStack(spacing: 0) {
                        Spacer().frame(height: 10)
                        Text("Line bar dashboard")
                        Spacer().frame(height: 10)
                    }
                    Divider().edgesIgnoringSafeArea(.all)
                    
                    
                    HStack(spacing: 0) {
                        VStack(spacing: 0) {
                            Spacer().frame(height: 50)
                            Text("Income").foregroundColor(.gray)
                            Text("\(self.netIncome) ₫")
                            SunburstView(configuration: self.configurationIncome)
                        }
                        Divider().edgesIgnoringSafeArea(.leading)
                        
                        VStack(spacing: 0) {
                            Spacer().frame(height: 50)
                            Text("Expense").foregroundColor(.gray)
                            Text("\(self.netIncome - 10000) ₫")
                            SunburstView(configuration: self.configurationExpense)
                        }
                        
                    }
//                    SettingsView(configuration: self.configuration)
                }
            )
        })
    }
}

class ReportHostingViewController: UIHostingController<RootView> {
    
    var db:DBHelper = DBHelper()
    var transactions:[TransactionsGroupByCategory] = []
    
    var configurationIncome = SunburstConfiguration(nodes: [])
    
    var configurationExpense = SunburstConfiguration(nodes: [])
    
    
    required init?(coder: NSCoder) {
        
        // MARK: - Load Pie Chart
        transactions = db.getTransactionsGroupByCategory()
        let transactionsQuantity = db.getTransactionsQuantity()
        
        var nodes: [Node] = []
        for (index, transaction) in transactions.enumerated() {
            
            
            let category = db.getCategoriesById(categoryId: transaction.categoryId)
            
            let percent: Double = Double((transaction.quantity * 100) / Int(transactionsQuantity))
            
            print(">>> ", index, ":", transaction.categoryId, ":", transaction.quantity, ":", transactionsQuantity, ":", percent)
            
            nodes.append(Node(name: category.name,
                            showName: true,
                            image: UIImage(named: category.icon),
                            value: percent,
                            backgroundColor: UIColor.random()))
        }
        
        configurationIncome = SunburstConfiguration(nodes: nodes)
        configurationExpense = SunburstConfiguration(nodes: nodes)
        
        let netIncomeSummary: Int32 = db.getTransactionsAmountSummary()
        
        super.init(coder: coder,rootView: RootView(configurationIncome: configurationIncome, configurationExpense: configurationExpense, netIncome: netIncomeSummary));
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
}
