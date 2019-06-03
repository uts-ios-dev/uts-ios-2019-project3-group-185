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
    @IBOutlet weak var loginErrorTxt: UILabel!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBAction func buttonLogin(_ sender: Any) {
        signIn()
    }
    
    @IBAction func buttonCreate(_ sender: Any) {
        self.performSegue(withIdentifier: "CreateAccountTransition", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
    }
    
    func signIn() {
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
                            if let _ = error, user == nil {
                                print("Not athenticated")
                                self.loginErrorTxt.isHidden = false
                                return
                            }
                            self.performSegue(withIdentifier: "QuestionTransition", sender: self)
        }
    }
}

