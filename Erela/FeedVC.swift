//
//  FeedVC.swift
//  Erela
//
//  Created by oskarGuest on 2017-07-03.
//  Copyright © 2017 oskar ljungdahl. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase


class FeedVC: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POSTS.observe(.value) { (snapshot) in
            print(snapshot.value)
        }

    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
    
    
    
    @IBAction func signOutBtn(_ sender: Any) {
        
        let  keyChainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("OSKAR: \(keyChainResult)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
            }
    
}
