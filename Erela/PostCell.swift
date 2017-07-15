//
//  PostCell.swift
//  Erela
//
//  Created by oskarGuest on 2017-07-08.
//  Copyright © 2017 oskar ljungdahl. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    
    @IBOutlet weak var  profilemg: UIImageView!
    @IBOutlet weak var  userName: UILabel!
    @IBOutlet weak var  postImage: UIImageView!
    @IBOutlet weak var  caption: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
    
    
    var post: Post!
    
    override func awakeFromNib(){
        super.awakeFromNib()
        
    }

    func configureCell(post: Post, img: UIInage? = nil){
        self.post = post
        self.caption.text = post.caption
        self.likesLabel.text = "\(post.likes)"
        
        
        if img != nil {
            self.postImage.image = img
        } else {
         
                let ref = FIRStorage.storage().reference(forURL: imageUrl)
                ref.data(withMaxSize: 2 * 1024 * 1024, compelation:{(data, error) in
                    if error != nil {
                        print("OSKAR:  Unable  to download image f fb s")
                    }else {
                        print("OSKAR: image Download ")
                        if let imgData = data{
                            if let img = UIImage(data: imgData) {
                                self.postImage.image = img
                                FeedVC.imageCache.setObject(img, forKey: post.imageUrl)
                            }
                        }
                    }
                
                })
            }
        }
    }
    
