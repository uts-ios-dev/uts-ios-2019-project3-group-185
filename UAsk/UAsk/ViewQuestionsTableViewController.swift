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
    let nameTxt : String!
    let docId: String!
}

class ViewQuestionsTableViewController: UITableViewController {
    
    var arrayOfData: [cellData] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        createArray()
    }
    
    func createArray() {
        var tempTxt: [cellData] = []
        //Choosing collection
        db.collection("questions").getDocuments()
            { (QuerySnapshot, err) in
                if err != nil {
                    print("Error getting documents: \(String(describing: err))");
                }
                else {
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

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfData.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ViewQuestionsTableTableViewCell", owner: self, options: nil)?.first as! ViewQuestionsTableTableViewCell
        
        cell.selectionStyle = .none
        
        cell.cellLabelContent.text = arrayOfData[indexPath.row].quesTxt
        cell.cellLabelTest.text = arrayOfData[indexPath.row].nameTxt
        
        if (arrayOfData[indexPath.row].facTxt == "Engineering and IT") {
            cell.cardView.backgroundColor = UIColor.red
        }
        if (arrayOfData[indexPath.row].facTxt == "Arts and Social Sciences") {
            cell.cardView.backgroundColor = UIColor.orange
        }
        if (arrayOfData[indexPath.row].facTxt == "Design, Architecture and Building") {
            cell.cardView.backgroundColor = UIColor.brown
        }
        if (arrayOfData[indexPath.row].facTxt == "Law") {
            cell.cardView.backgroundColor = UIColor.purple
        }
        if (arrayOfData[indexPath.row].facTxt == "Business") {
            cell.cardView.backgroundColor = UIColor.blue
        }
        if (arrayOfData[indexPath.row].facTxt ==  "Science") {
            cell.cardView.backgroundColor = UIColor.magenta
        }
        if (arrayOfData[indexPath.row].facTxt ==  "Health") {
            cell.cardView.backgroundColor = UIColor.green
        }
        if (arrayOfData[indexPath.row].facTxt ==  "Trans-Disciplinary Innovation") {
            cell.cardView.backgroundColor = UIColor.lightGray
        }

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
        default:
            viewController = "AnswersViewController"
        }
        
       if let privateAnswersViewController = storyboard.instantiateViewController(withIdentifier: viewController) as? AnswersViewController {
            privateAnswersViewController.questionUid = arrayOfData[indexPath.row].docId
        
            self.present(privateAnswersViewController, animated:true, completion: nil)
        }
    }
    
}
