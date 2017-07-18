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
    @IBOutlet weak var likeImg: UIImageView!

    var post: Post!
    var likesRef: FIRDatabaseReference!
    
    override func awakeFromNib(){
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tap.numberOfTapsRequired = 1
        likeImg.addGestureRecognizer(tap)
    }
    
    func configureCell(post: Post, img: UIImage? = nil){
        
        self.post = post
        likesRef = DataService.ds.REF_USER_CURRENT.child("likes").child(post.postKey)
        self.caption.text = post.caption
        self.likesLabel.text = "\(post.likes)"
        
        
        if img != nil {
            self.postImage.image = img
        } else {
            
            let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion:{(data, error) in
                if error != nil {
                    print("OSKAR:  Unable  to download image f fb s")
                }else {
                    print("OSKAR: image Download ")
                    if let imgData = data{
                        if let img = UIImage(data: imgData) {
                            self.postImage.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                        }
                    }
                }
                
            })
        }
        
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let _ =   snapshot.value as? NSNull {
                self.likeImg.image = UIImage(named: "empty")
                print("tomt")
                
            }
            else{
                self.likeImg.image = UIImage(named: "full")
                print("full")
            }
            
        })
        
    }
  func likeTapped(){
    
    likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
        if let _ =   snapshot.value as? NSNull {
            self.likeImg.image = UIImage(named: "full")
            self.post.adjustLikes(addLike: true)
            self.likesRef.setValue(true)
            print("fullHEart")
        }
        else{
            self.likeImg.image = UIImage(named: "empty")
            self.post.adjustLikes(addLike: false)
            self.likesRef.removeValue(true)
            self.likesRef.removeValue()
            print("tomt")
            
        }
        
    })
            
        }
    }

    
