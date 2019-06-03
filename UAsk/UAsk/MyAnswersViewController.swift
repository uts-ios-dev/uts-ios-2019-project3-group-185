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

class MyAnswersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myQuestionContent: UILabel!
    @IBOutlet weak var myQuestionsName: UILabel!
    @IBOutlet weak var answerTableView: UITableView!
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var arrayOfData: [cellData] = []
    let db = Firestore.firestore()
    var uId: String?
    let tableView = UITableView()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("MyAnswersTableViewCell", owner: self, options: nil)?.first as! MyAnswersTableViewCell
        
        cell.selectionStyle = .none
        
        cell.answerTestLabel.text = arrayOfData[indexPath.row].nameTxt
        //cell.cellLabelTest.text = arrayOfData[indexPath.row].nameTxt
        
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
        tableView.dataSource = self
        tableView.delegate = self
        createArray()
        loadData()
    }
    
    func loadData() {
        db.collection("questions").document(uId!).getDocument()
            { (QuerySnapshot, err) in
                if err != nil {
                    print("Error getting documents: \(String(describing: err))");
                }
                else {
                    let document = QuerySnapshot
                    let data = document!.data()
                    _ = document!.documentID
                    
                    let data2 = data!["questionTxt"] as? String
                    let data3 = data!["name"]as? String
                
                
                    self.myQuestionContent.text = data2
                    self.myQuestionsName.text = data3
                }
            }
    }
    
    func createArray() {
        var tempTxt: [cellData] = []
        
        //Choosing collection
        db.collection("questions").getDocuments() { (QuerySnapshot, err) in
                if err != nil {
                    print("Error getting documents: \(String(describing: err))");
                } else {
                    
                    for document in QuerySnapshot!.documents {
                        self.arrayOfData.removeAll()
                        let data = document.data()
                        let docId = document.documentID
                        
                        let data1 = data["faculty"] as? String
                        let data2 = data["questionTxt"] as? String
                        let data3 = data["name"]as? String
                        let data4 = docId
                        
                        let txt = cellData(facTxt: data1!, quesTxt: data2!, nameTxt: data3!, docId: data4)
                        print(txt)
                        
                        tempTxt.append(txt)
                        print("hello \(tempTxt)")
                    }
                    
                    self.arrayOfData = tempTxt
                    print("hello \(self.arrayOfData)")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
        }
    }
}
