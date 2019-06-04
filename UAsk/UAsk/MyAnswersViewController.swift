//
//  CreateUserViewController.swift
//  UAsk
//
//  Created by William Hong on 22/5/19.
//  Copyright © 2019 Megan Farleigh. All rights reserved.
//  View Controller for the viewing answers sceen/page. 
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

struct cellAnswerData {
    let answerTxt: String?
}

class MyAnswersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myQuestionContent: UILabel!
    @IBOutlet weak var myQuestionsName: UILabel!
    @IBOutlet weak var answerTableView: UITableView!
    var arrayOfData: [cellAnswerData] = []
    let db = Firestore.firestore()
    var uId: String?
    let tableView = UITableView()
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("MyAnswersTableViewCell", owner: self, options: nil)?.first as! MyAnswersTableViewCell
        cell.selectionStyle = .none
        cell.answerTestLabel.text = arrayOfData[indexPath.row].answerTxt
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 78
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController : String
        switch indexPath.row {
        default:
            viewController = "AnswersViewController"
        }
        
        let privateAnswersViewController = storyboard.instantiateViewController(withIdentifier: viewController)
        
        self.present(privateAnswersViewController, animated:true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createArray()
        loadData()
        tableView.reloadData()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadData() {
        db.collection("questions").document(uId!).getDocument()
            { (QuerySnapshot, err) in
                if err != nil{
                    print("Error getting documents: \(String(describing: err))");
                } else {
                        let document = QuerySnapshot
                        let data = document!.data()
                        
                        let data2 = data!["questionTxt"] as? String
                        let data3 = data!["name"]as? String
                    
                        self.myQuestionContent.text = data2
                        self.myQuestionsName.text = data3
                }
            }
    }
    
    func createArray() {
        var tempTxt: [cellAnswerData] = []

        db.collection("questions").document(uId!).collection("answers").getDocuments
            { (QuerySnapshot, err) in
                if err != nil {
                    print("Error getting documents: \(String(describing: err))");
                } else {
                    for document in QuerySnapshot!.documents {
                        self.arrayOfData.removeAll()
                        let data = document.data()
                        
                        let data1 = data["answerTxt"] as? String
   
                        let txt = cellAnswerData(answerTxt: data1!)
                        
                        tempTxt.append(txt)
                    }
                    
                    self.arrayOfData = tempTxt
                    
                    DispatchQueue.main.async {
                    self.tableView.reloadData()
                    }
                }
        }
    }
}
