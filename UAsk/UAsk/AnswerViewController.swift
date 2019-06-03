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
    let fDb = Firestore.firestore()
    var uid = ""
    var username = ""
    var questionUid: String?
    
    @IBOutlet weak var errorTxt: UILabel!
    @IBOutlet weak var answerTxt: UITextView!
    @IBOutlet weak var hello: UILabel!
    
    @IBAction func submitButton(_ sender: Any) {
        if (checkFieldValues()) {
            addAnswerToDb()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addAnswerToDb() {
        db.collection("questions").document(questionUid ?? "nil").collection("answers").addDocument( data: [
            "answerTxt": answerTxt.text,
            "userId": uid,
            "name": username
            ])
    }
    @IBOutlet weak var questionTxtLabel: UILabel!
    
    func setData() {
        print("bra \(questionUid)")
        fDb.collection("questions").document(questionUid!).getDocument()
            { (QuerySnapshot, err) in
                if err != nil
                {
                    print("Error getting documents: \(String(describing: err))");
                }
                else
                {
                    let document = QuerySnapshot
                    let data = document!.data()
                    let data2 = data!["questionTxt"] as? String
                    self.questionTxtLabel.text = data2
                }
            }
    }
    
    func checkFieldValues() -> Bool{
        guard let answer = answerTxt.text, !answer.isEmpty else {
            errorTxt.isHidden = false
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
        
        setData()   
        
        // Set up firestore
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
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
                print(data["name"]!)
                self.username = data["name"] as! String
            } else {
                print("Document does not exist")
            }
        }
    }
}
