//
//  ViewController.swift
//  UAsk
//
//  Created by Megan Farleigh on 22/5/19.
//  Copyright © 2019 Megan Farleigh. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailEditTxt: UITextField!
    
    @IBOutlet weak var passEditTxt: UITextField!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBAction func buttonLogin(_ sender: Any) {
        guard
            let email = emailEditTxt.text,
            let password = passEditTxt.text,
            email.count > 0,
            password.count > 0
            else {
                return
        }
        Auth.auth().signIn(withEmail: email,
                           password: password) { (user, error) in
                            if let error = error, user == nil {
                                print("Not athenticated")
                                return
                            }
                            self.performSegue(withIdentifier: "QuestionTransition", sender: self)
                            
        }
        
        
//        if (signIn()) {
//            print("Auth successful")
//            self.performSegue(withIdentifier: "QuestionTransition", sender: self)
//        } else {
//            print("Not athenticated")
//        }
        
    }
    
    @IBAction func buttonCreate(_ sender: Any) {
        self.performSegue(withIdentifier: "CreateAccountTransition", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // Handle authenticated state
        }
    }
    
    func signIn() -> Bool {
        var successful = false
        guard
            let email = emailEditTxt.text,
            let password = passEditTxt.text,
            email.count > 0,
            password.count > 0
            else {
                return false
        }
        Auth.auth().signIn(withEmail: email,
                           password: password) { (user, error) in
                            if let error = error, user == nil {
                                successful = false
                            }
        }
        
        return successful
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        do {
//            try Auth.auth().signOut()
//            self.dismiss(animated: true, completion: nil)
//        } catch (let error) {
//            print("Auth sign out failed: \(error)")
//        }
//    }

}

