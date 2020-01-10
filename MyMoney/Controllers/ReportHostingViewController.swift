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
    
    var body: some View {
        AnyView(GeometryReader { geometry -> AnyView in
            return AnyView(
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        VStack(spacing: 0) {
                            Spacer().frame(height: 10)
                            Text("Opening balance   ").foregroundColor(.gray)
                            Text("-100,000,000 ₫   ")
                        }
                        Divider()
                        VStack(spacing: 0) {
                            Spacer().frame(height: 10)
                            Text("   Ending balance").foregroundColor(.gray)
                            Text("   99,000,000 ₫")
                        }
                    }.frame(height: 70)
                    
                    Divider().edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 0) {
                        Spacer().frame(height: 10)
                        Text("Net Income").foregroundColor(.gray)
                        Text("999,000,000 ₫")
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
                            Text("10,000,000 ₫")
                            SunburstView(configuration: self.configurationIncome)
                        }
                        Divider().edgesIgnoringSafeArea(.leading)
                        
                        VStack(spacing: 0) {
                            Spacer().frame(height: 50)
                            Text("Expense").foregroundColor(.gray)
                            Text("9,000,000 ₫")
                            SunburstView(configuration: self.configurationExpense)
                        }
                        
                    }
//                    SettingsView(configuration: self.configuration)
                }
            )
            
            
            
            
            
//            if geometry.size.width <= geometry.size.height {
//                return AnyView(
//                    VStack(spacing: 0) {
//                        SunburstView(configuration: self.configuration)
//                        Divider()
//                            .edgesIgnoringSafeArea(.all)
//                        SettingsView(configuration: self.configuration)
//                    }
//                )
//            }
//            else {
//                return AnyView(
//                    HStack(spacing: 0) {
//                        SunburstView(configuration: self.configuration)
//                            .edgesIgnoringSafeArea(.all)
//                        Divider()
//                            .edgesIgnoringSafeArea(.all)
////                        SettingsView(configuration: self.configuration)
//                    }
//                )
//            }
        })
    }
}

class ReportHostingViewController: UIHostingController<RootView> {

    let configurationIncome = SunburstConfiguration(nodes: [
        Node(name: "Walking",
             showName: false,
             image: UIImage(named: "walking"),
             value: 10.0,
             backgroundColor: .systemBlue),
        Node(name: "Home",
             showName: false,
             image: UIImage(named: "house"),
             value: 75.0,
             backgroundColor: .systemTeal)
    ])
    
    let configurationExpense = SunburstConfiguration(nodes: [
        Node(name: "Restaurant",
            showName: false,
            image: UIImage(named: "eating"),
            value: 30.0,
            backgroundColor: .systemRed),
        
        Node(name: "Walking",
             showName: false,
             image: UIImage(named: "walking"),
             value: 10.0,
             backgroundColor: .systemBlue),
        
        Node(name: "Home",
             showName: false,
             image: UIImage(named: "house"),
             value: 75.0,
             backgroundColor: .systemTeal),
        Node(name: "Shoping",
            showName: false,
            image: UIImage(named: "house"),
            value: 5.0,
            backgroundColor: .systemPink)
    ])
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: RootView(configurationIncome: configurationIncome, configurationExpense: configurationExpense));
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


//class ReportHostingViewController: UIHostingController<RootView> {
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder,rootView: RootView());
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//}

//struct RootView: View {
//  var body: some View {
//      VStack {
//          Text("Second View").font(.system(size: 36))
//          Text("Loaded by SecondView").font(.system(size: 14))
//      }
//  }
//}
