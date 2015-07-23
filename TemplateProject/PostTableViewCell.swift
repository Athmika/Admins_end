//
//  PostTableViewCell.swift
//  Admin_end
//
//  Created by Athmika Senthilkumar on 7/17/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sLabel: UILabel!
    
    
    @IBOutlet weak var dotButton: UIImageView!
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
