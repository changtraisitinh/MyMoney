//
//  Category.swift
//  MyMoney
//
//  Created by Admin on 13/01/2020.
//  Copyright © 2020 changtraisitinh. All rights reserved.
//

import Foundation

class Category {
    
    var id : Int = 0
    var name : String = ""
    var icon : String = ""
    var type : String = ""
    
    init(id: Int, name: String, icon: String, type: String) {
        self.id = id
        self.name = name
        self.icon = icon
        self.type = type
    }

}
