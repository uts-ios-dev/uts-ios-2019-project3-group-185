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
    
    @IBOutlet weak var questionTxt: UITextView!
    @IBOutlet weak var facultyPicker: UIPickerView!
    @IBOutlet weak var submitQButton: UIButton!
    @IBOutlet weak var successfulTxt: UILabel!
    
    var facultyData = ["Faculty","Engineering and IT", "Arts and Social Sciences", "Design, Architecture and Building", "Law", "Business", "Science", "Health", "Trans-Disciplinary Innovation"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            creatQuestionInFirebase()
            clearField()
            successfulTxt.isHidden = false
        }
    }
    
    func checkFieldValues() -> Bool {
        let selectedValue = facultyData[facultyPicker.selectedRow(inComponent: 0)]
        
        guard let question = questionTxt.text, !question.isEmpty else {
            return false
        }
        
        if (selectedValue == "Faculty") {
            return false
        }
        return true
    }

    func creatQuestionInFirebase() {
        var uid = ""
        let user = Auth.auth().currentUser
        if let user = user {
            uid = user.uid
        }
        
        db.collection("questions").addDocument(data: [
            "faculty": facultyData[facultyPicker.selectedRow(inComponent: 0)],
            "questionTxt": questionTxt.text,
            "userId": uid
            ])
    }
    
    func clearField() {
        questionTxt.text.removeAll()
        facultyPicker.reloadAllComponents()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
