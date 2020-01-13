//
//  Category.swift
//  MyMoney
//
//  Created by Admin on 13/01/2020.
//  Copyright © 2020 changtraisitinh. All rights reserved.
//

import Foundation

class Category: NSObject, NSCoding {
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
        coder.encode(icon, forKey: "icon")
    }
    
    required init(coder decoder: NSCoder) {
        self.id = decoder.decodeInteger(forKey: "id")
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.icon = decoder.decodeObject(forKey: "icon") as? String ?? ""
    }
    
    var id : Int
    var name : String
    var icon : String
    
    init(id: Int, name: String, icon: String) {
        self.id = id
        self.name = name
        self.icon = icon
    }

}
