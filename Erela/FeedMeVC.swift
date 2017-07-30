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

class ViewController2: UIViewController, UITableViewDelegate,UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView:UITableView!
  
    @IBOutlet weak var captionField: UITextField!
     @IBOutlet weak var imageAdd: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
    }
    

    @IBAction func signOut(_ sender: Any) {
        let  keyChainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("OSKAR: \(keyChainResult)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "logOut", sender: nil)
    }



}
