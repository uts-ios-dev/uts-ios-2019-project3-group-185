//
//  PrivateAnswersViewController.swift
//  UAsk
//
//  Created by William Hong on 22/5/19.
//  Copyright © 2019 Megan Farleigh. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AnswersViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    var db: Firestore!
    var uid = ""
    var username = ""
    var questionUid: String?
    
    @IBOutlet weak var answerTxt: UITextView!
    @IBAction func submitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        if (checkFieldValues()) {
            addAnswerToDb()
        }
        
        
    }
    
    func addAnswerToDb() {
        db.collection("questions").document(questionUid ?? "nil").collection("answers").addDocument( data: [
            "answerTxt": answerTxt.text,
            "userId": uid
            ])
    }
    
    func checkFieldValues() -> Bool{
        guard let answer = answerTxt.text, !answer.isEmpty else {
            return false
        }
        
        return true
    }
    
    @IBOutlet weak var hello: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // Handle authenticated state
        }
        
        // [START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        // Do any additional setup after loading the view.
        
        getUserData()
    }
    
    func getUserData() {
        let user = Auth.auth().currentUser
        if let user = user {
            uid = user.uid
        }
        
        let docRef = db.collection("users").document(uid)
        
        docRef.getDocument { (document, error) in
            if let data = document?.data(), document?.exists ?? false {
                print(data["name"])
                self.username = data["name"] as! String
            } else {
                print("Document does not exist")
            }
        }
        //        addQuestionToDb()
        //        clearField()
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
