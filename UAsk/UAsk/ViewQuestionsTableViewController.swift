//
//  ViewQuestionsTableViewController.swift
//  UAsk
//
//  Created by William Hong on 27/5/19.
//  Copyright © 2019 Megan Farleigh. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

struct cellData{
    let facTxt : String!
    let quesTxt : String!
    //  let image : UIImage!
}

struct cellText{
    let text : String!
}

class ViewQuestionsTableViewController: UITableViewController {
    
    var arrayOfData: [cellData] = []
    
    var arrayOfCellData = [cellData]()
    var arrayOfTitle = [cellData]()
    var arrayOfNames = [cellText]()
    let authentication = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //loadData()
        createArray()
        
        
        
        
    }
    
    func createArray()
    {
        var tempTxt: [cellData] = []
        
        //Choosing collection
        db.collection("questions").getDocuments()
            { (QuerySnapshot, err) in
                if err != nil
                {
                    print("Error getting documents: \(String(describing: err))");
                }
                else
                {
                    //For-loop
                    for document in QuerySnapshot!.documents
                    {
                        self.arrayOfData.removeAll()
                        
                        let data = document.data()
                        
                            
                            let data1 = data["faculty"] as? String
                            let data2 = data["questionTxt"] as? String
                            
                            let txt = cellData(facTxt: data1!, quesTxt: data2!)
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

    
    
    func loadData() {
        
        
        
//        db.collection("questions").getDocuments{(snapshot, error) in
//            if error != nil {
//                print(error)
//            }
//            else {
//                for document in (snapshot?.documents)! {
//                    if let titleTxt = document.data()["questionTxt"] as? String {
//                        if let userID = document.data()["userId"] as? String {
//                            self.db.collection("users").document(userID).getDocument{(snapshot, error) in
//                                if let document = snapshot {
//                                    let nameTxt = document.get("name")
//                                    self.arrayOfNames.append(cellText(text: nameTxt as? String))
//                                    print(self.arrayOfNames)
//                                }
//                                else {
//                                    print(error)
//                                }
//
//                                self.tableView.reloadData()
//                            }
//                        }
//                        print(self.arrayOfNames)
//                        self.arrayOfCellData.append(cellData(text: titleTxt))
//
//
//
//                    }
//                }
//            }
//            self.tableView.reloadData()
//        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("ViewQuestionsTableTableViewCell", owner: self, options: nil)?.first as! ViewQuestionsTableTableViewCell
        
        cell.cellLabelContent.text = arrayOfData[indexPath.row].quesTxt
        cell.cellLabelTest.text = arrayOfData[indexPath.row].facTxt
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 250
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController : String
        switch indexPath.row {
        case 0: //For "one"
            viewController = "AnswersViewController"
        case 1: //For "two"
            viewController = "LoginViewController"
        default: //For "three"
            viewController = "AnswersViewController"
        }
        
        let privateAnswersViewController = storyboard.instantiateViewController(withIdentifier: viewController)
        
        self.present(privateAnswersViewController, animated:true, completion: nil)
    }
    
}
