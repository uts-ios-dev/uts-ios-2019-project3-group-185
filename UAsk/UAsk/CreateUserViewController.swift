//
//  CreateUserViewController.swift
//  UAsk
//
//  Created by William Hong on 22/5/19.
//  Copyright © 2019 Megan Farleigh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class CreateUserViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return facultyData.count
    }
    
    var handle: AuthStateDidChangeListenerHandle?
    var db: Firestore!

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var facultyPicker: UIPickerView!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var password1Txt: UITextField!
    @IBOutlet weak var password2Txt: UITextField!
    
    var email = ""
    var password = ""
    
    var facultyData = ["Faculty","Engineering and IT", "Arts and Social Sciences", "Design, Architecture and Building", "Law", "Business", "Science", "Health", "Trans-Disciplinary Innovation"]
    
    @IBAction func createAccountButton(_ sender: Any) {
        if (checkFieldValues()) {
            createFirebaseAccount()
            self.performSegue(withIdentifier: "LoginTransition", sender: self)
        } else {
            print("Failed")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return facultyData[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facultyData = ["Faculty", "Engineering and IT", "Arts and Social Sciences", "Design, Architecture and Building", "Law", "Business", "Science", "Health", "Trans-Disciplinary Innovation"]
        self.facultyPicker.dataSource = self
        self.facultyPicker.delegate = self
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in 
            // Handle authenticated state
        }
        
        // [START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
        // Do any additional setup after loading the view.
    }
    
    func checkFieldValues() -> Bool {
        guard let email = emailTxt.text, !email.isEmpty else {
            return false
        }
        
        guard let username = usernameTxt.text, !username.isEmpty else {
            return false
        }
        
        guard let password1 = password1Txt.text, !password1.isEmpty else {
            return false
        }
        
        guard let password2 = password2Txt.text, !password2.isEmpty else {
            return false
        }
        
        if (!(email.contains("@student.uts.edu.au"))) {
            return false
        }
        
        let selectedValue = facultyData[facultyPicker.selectedRow(inComponent: 0)]
        
        if (selectedValue == "Faculty") {
            return false
        }
        
        if (password1 != password2) {
            return false
        }
        
        return true
    }

    func createFirebaseAccount() {
        guard let email = emailTxt.text, !email.isEmpty else {
            return
        }
        
        guard let password = password1Txt.text, !password.isEmpty else {
            return
        }
        
        
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error, authResult == nil {
                // do stuff to handle
                print("Firebase error")
            } else {
                print("Hello \(String(describing: Auth.auth().currentUser?.uid))")
                let uid = Auth.auth().currentUser?.uid
                
                self.db.collection("users").document(uid!).setData([
                    "name": self.usernameTxt.text,
                    "faculty": self.facultyData[self.facultyPicker.selectedRow(inComponent: 0)],
                    "questions": [],
                    ])
               
            }
        }
        
//        Auth.auth().signIn(withEmail: email,
//                           password: password) { (user, error) in
//                            if let error = error, user == nil {
//                                print("Not athenticated")
//                                return
//                            }
//        }
        
        
        
//        let user = Auth.auth().currentUser
//        if let user = user {
//            uid = user.uid
//            let email = user.email
//        }
      
        
        
        print("Firebase Successful")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        try! Auth.auth().signOut()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        try! Auth.auth().signOut()
    }
    
}
