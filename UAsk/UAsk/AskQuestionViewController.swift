//
//  AskQuestionViewController.swift
//  UAsk
//
//  Created by William Hong on 29/5/19.
//  Copyright © 2019 Megan Farleigh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AskQuestionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var handle: AuthStateDidChangeListenerHandle?
    var db: Firestore!
    
    @IBOutlet weak var errorTxt: UILabel!
    @IBOutlet weak var questionTxt: UITextView!
    @IBOutlet weak var facultyPicker: UIPickerView!
    @IBOutlet weak var submitQButton: UIButton!
    @IBOutlet weak var successfulTxt: UILabel!
    
    var facultyData = ["Faculty","Engineering and IT", "Arts and Social Sciences", "Design, Architecture and Building", "Law", "Business", "Science", "Health", "Trans-Disciplinary Innovation"]
    
    var uid = ""
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTxt.layer.cornerRadius = 15
        questionTxt.clipsToBounds = true
        
        self.facultyPicker.dataSource = self
        self.facultyPicker.delegate = self
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
        
        // Firestore setup
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        getUserData()
    }

    @IBAction func signOutBtn(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Auth error")
        }
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController : String
            viewController = "LoginViewController"
            
            
            if let loginViewController = storyboard.instantiateViewController(withIdentifier: viewController) as? LoginViewController {
                self.present(loginViewController, animated:true, completion: nil)
            }
    }
        

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return facultyData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return facultyData[row]
    }
    
    @IBAction func submitQuestion(_ sender: Any) {
        if (checkFieldValues()) {
            addQuestionToDb()
            clearField()
            showSuccessTxt()
        }
    }
    
    func checkFieldValues() -> Bool {
        let selectedValue = facultyData[facultyPicker.selectedRow(inComponent: 0)]
        
        guard let question = questionTxt.text, !question.isEmpty else {
            errorTxt.isHidden = false
            return false
        }
        
        if (selectedValue == "Faculty") {
            errorTxt.text = "Please choose a faculty for the question"
            errorTxt.isHidden = false
            return false
        }
        
        errorTxt.isHidden = true
        return true
    }

    func getUserData() {
        let user = Auth.auth().currentUser
        if let user = user {
            uid = user.uid
        }
        
        let docRef = db.collection("users").document(uid)
        
        docRef.getDocument { (document, error) in
            if let data = document?.data(), document?.exists ?? false {
                print(data["name"]!)
                self.username = data["name"] as! String
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func addQuestionToDb() {
        db.collection("questions").addDocument(data: [
            "faculty": facultyData[facultyPicker.selectedRow(inComponent: 0)],
            "questionTxt": questionTxt.text,
            "userId": uid,
            "name": username
            ])
    }
    
    func clearField() {
        questionTxt.text.removeAll()
        facultyPicker.reloadAllComponents()
    }
    
    func showSuccessTxt() {
        successfulTxt.isHidden = false
    }
}
