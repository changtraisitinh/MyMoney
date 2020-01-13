//
//  Category.swift
//  MyMoney
//
//  Created by Admin on 13/01/2020.
//  Copyright © 2020 changtraisitinh. All rights reserved.
//

import Foundation

class Category {
    var id : Int
    var name : String
    var icon : String
    
    init(id: Int, name: String, icon: String) {
        self.id = id
        self.name = name
        self.icon = icon
    }

}
