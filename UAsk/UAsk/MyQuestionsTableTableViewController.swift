//
//  MyQuestionsTableTableViewController.swift
//  UAsk
//
//  Created by William Hong on 29/5/19.
//  Copyright © 2019 Megan Farleigh. All rights reserved.
//

import UIKit
import FirebaseFirestore

class MyQuestionsTableTableViewController: UITableViewController {
        
    var arrayOfCellData = [cellData]()
    var arrayOfTitle = [String]()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
        
    }
    
    func loadData() {
        db.collection("questions").getDocuments{(snapshot, error) in
            if error != nil {
                print(error)
            }
            else {
                for document in (snapshot?.documents)! {
                    if let titleTxt = document.data()["faculty"] as? String {
                        self.arrayOfCellData.append(cellData(text: titleTxt))
                        
                    }
                }
            }
            self.tableView.reloadData()
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCellData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("ViewQuestionsTableTableViewCell", owner: self, options: nil)?.first as! ViewQuestionsTableTableViewCell
        cell.cellLabelTest.text = arrayOfCellData[indexPath.row].text
        
        
        //print("Array is populated \(arrayOfCellData)")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 73
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
