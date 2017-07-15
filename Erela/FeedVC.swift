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


class FeedVC: UIViewController, UITableViewDelegate,UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView:UITableView!
    
    var posts = [Post]()
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    var imagePicker: UIImagePickerController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
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
           self.tableView.reloadData() 
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]

        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell{

            
            if let img = FeedVC.imageCache.object(forKey: post.imageUrl){
                cell.configureCell(post: post, img: img)
                return cell
            } else {
                
                cell.configureCell(post: post)
                return cell
            }
            
            
        } else {
            return PostCell()
        }
    }
    /*
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage
            imageAdd.image = image
    
    }
        
        imagePicker.dismiss(animated: true, completion: nil)
    
        '}
    
    @IBAction func addImage(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    */
    
    @IBAction func signOutBtn(_ sender: Any) {
        
        let  keyChainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("OSKAR: \(keyChainResult)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
            }
    
}
