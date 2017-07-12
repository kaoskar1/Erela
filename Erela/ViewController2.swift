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

    override func viewDidLoad() {
        super.viewDidLoad()

        
        DataService.ds.REF_POSTS.observe(.value) { (snapshot) in
            print(snapshot.value)
        }
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
