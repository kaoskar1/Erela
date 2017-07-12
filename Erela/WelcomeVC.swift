//
//  WelcomeVC.swift
//  Erela
//
//  Created by oscar ljungdahl on 2017-06-05.
//  Copyright © 2017 oskar ljungdahl. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import SwiftKeychainWrapper


class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtn(_ sender: UIButtonX) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
            print("OSKAR: unable to authenticate with facebook")
            
            } else if result?.isCancelled == true{
                print("OSKAR: user  cancelled  facebook authentic")
            } else {
            print("OSKAR: success authenticate with facebok")
                
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
            
            print("OSKAR: Unable to authenticate with firebase")
            
            } else {
            print("OSKAR: successfully authenticate with firebase")
            
            }
        })
        
        
    }
    
    @IBAction func kkkk(_ sender: UIButton) {

        let  keyChainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("OSKAR: \(keyChainResult)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    
}

