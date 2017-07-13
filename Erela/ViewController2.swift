//
//  ViewController2.swift
//  Erela
//
//  Created by oskarGuest on 2017-07-13.
//  Copyright © 2017 oskar ljungdahl. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class ViewController2: UIViewController {
    
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject>{
                         let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
                
            }
            
        })
}


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
