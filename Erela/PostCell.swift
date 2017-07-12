//
//  PostCell.swift
//  Erela
//
//  Created by oskarGuest on 2017-07-08.
//  Copyright © 2017 oskar ljungdahl. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var  profilemg: UIImageView!
    @IBOutlet weak var  userName: UILabel!
    @IBOutlet weak var  postImage: UIImageView!
    @IBOutlet weak var  caption: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
    
    
    override func awakeFromNib(){
        super.awakeFromNib()
        
    }

   
    
}
