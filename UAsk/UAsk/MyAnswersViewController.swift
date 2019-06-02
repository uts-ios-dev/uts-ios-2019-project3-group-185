//
//  CreateUserViewController.swift
//  UAsk
//
//  Created by William Hong on 22/5/19.
//  Copyright © 2019 Megan Farleigh. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class MyAnswersViewController: UIViewController {
    
    
    let db = Firestore.firestore()
    var uId: String?
 
    @IBOutlet weak var myQuestionContent: UILabel!
    @IBOutlet weak var myQuestionsName: UILabel!
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        print("why \(uId)")
        // Do any additional setup after loading the view.
    }
    
    
    func loadData()
    {
       
        db.collection("questions").document(uId!).getDocument()
            { (QuerySnapshot, err) in
                if err != nil
                {
                    print("Error getting documents: \(String(describing: err))");
                }
                else
                {
                    //For-loop
                    
                        let document = QuerySnapshot
                        let data = document!.data()
                        let docId = document!.documentID
                        
                        
                        let data1 = data!["faculty"] as? String
                        let data2 = data!["questionTxt"] as? String
                        let data3 = data!["name"]as? String
                        let data4 = docId
                    
                        self.myQuestionContent.text = data2
                        self.myQuestionsName.text = data3
                }
            }
    }
    
}
