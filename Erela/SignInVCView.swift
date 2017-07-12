//
//  SignInVC.swift
//  Erela
//
//  Created by oscar ljungdahl on 2017-06-05.
//  Copyright © 2017 oskar ljungdahl. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import SwiftKeychainWrapper


class SignInVC: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passWordField: UITextFieldX!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.defaultKeychainWrapper.string(forKey: KEY_UID){
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil{
            print("Oskar: unable to authenticate with Firebase")
            }else {
                print("Oskar: success to authenticate with Firebase" )
                if let user = user {
                    let userData = ["provider": user.providerID]
                    self.completeSignIn(id: user.uid, userData: userData)
                    
                }
               
                
            }
        })
    }
    
    @IBAction func signInbtn(_ sender: UIButtonX) {
        if let email = userNameField.text, let pwd = passWordField.text{
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                      print("Oskar: Email authenticate with Firebase ")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                }else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("Oskar Unable to authenticate with firebase using Email")
                        } else {
                        print("Oskar: successfly created a user with  firebase")
                            if let user = user {
                             let userData  = ["provider": user.providerID]
                                self.completeSignIn(id: user.uid, userData: userData)
                            }
                        }
                    })
                }
            })
        }
    }


    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        let keychainResult =  KeychainWrapper.standard.set(id , forKey: KEY_UID)
        print("OSKAR:  data saved \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
        print("OSKAR: Nu är du inne")
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
