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
//  let nameTxt : String!
}

struct cellText{
    let text : String!
}

class ViewQuestionsTableViewController: UITableViewController {
    
    var arrayOfData: [cellData] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //loadData()
        createArray()
        
        
        
        
    }
    
    func createArray()
    {
        var tempTxt: [cellData] = []
        var tempUser : String?
       
        
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
                        
                        
//                        self.db.collection("users").document(quesUser!).getDocument()
//                            {(QuerySnapshot, err) in
//                                if err != nil
//                                {
//                                    print("Error getting documents: \(String(describing: err))");
//                                }
//                                else
//                                {
//                                    if let document = QuerySnapshot {
//                                        tempUser = document.get("name") as? String
//                                        print("wtf \(String(describing: tempUser))")
//                                    }
//                                    print("omg \(String(describing: self.tempName))")
//                                    self.tempName = tempUser
//                                }
//                            }                  
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

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfData.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("ViewQuestionsTableTableViewCell", owner: self, options: nil)?.first as! ViewQuestionsTableTableViewCell
        
        cell.cellLabelContent.text = arrayOfData[indexPath.row].quesTxt
        cell.cellLabelTest.text = arrayOfData[indexPath.row].facTxt
        cell.cardView.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.cardView.layer.shadowColor = UIColor.black.cgColor
        cell.cardView.layer.shadowOpacity = 0.3
        cell.cardView.layer.shadowRadius = 4
        cell.cardView.layer.cornerRadius = 20
        cell.cardView.clipsToBounds = true
        cell.nameChip.layer.cornerRadius = 20
        cell.nameChip.clipsToBounds = true
        
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
