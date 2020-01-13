//
//  CategoryCell.swift
//  MyMoney
//
//  Created by Admin on 11/01/2020.
//  Copyright © 2020 changtraisitinh. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var imageViewCategory: UIImageView!
    @IBOutlet weak var labelCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        // invoke superclass implementation
        super.prepareForReuse()
        
        // reset (hide) the checkmark label
        self.labelCategory.isHidden = true
        self.imageViewCategory.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

//        if(self.imageView?.image != nil){
//
//
//        } else {
//            NSLog("")
//        }
    }
}
