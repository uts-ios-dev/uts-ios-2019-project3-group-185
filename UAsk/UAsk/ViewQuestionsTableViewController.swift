//
//  ViewQuestionsTableViewController.swift
//  UAsk
//
//  Created by William Hong on 27/5/19.
//  Copyright © 2019 Megan Farleigh. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct cellData{
    //  let cell : Int!
    let text : String!
    //  let image : UIImage!
}

class ViewQuestionsTableViewController: UITableViewController {
        
    var arrayOfCellData = [cellData]()
    var arrayOfTitle = [String]()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
        

//        arrayOfCellData = [cellData(cell: 1, text: "Will"),cellData(cell: 2, text: "Oliv"),cellData(cell: 3, text: "Meg")]
    }
    
    func loadData() {
        db.collection("questions").getDocuments{(snapshot, error) in
            if error != nil {
                print(error)
            }
            else {
                for document in (snapshot?.documents)! {
                    if let titleTxt = document.data()["questionTxt"] as? String {
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
        
        
        print("Array is populated \(arrayOfCellData)")
        
        return cell
        
        
//        if arrayOfCellData[indexPath.row].cell == 1 {
//            let cell = Bundle.main.loadNibNamed("ViewQuestionsTableTableViewCell", owner: self, options: nil)?.first as! ViewQuestionsTableTableViewCell
//
//            cell.cellLabelTest.text = arrayOfCellData[indexPath.row].text
//
//            return cell
//
//        }
//        else {
//            let cell = Bundle.main.loadNibNamed("ViewQuestionsTableTableViewCell", owner: self, options: nil)?.first as! ViewQuestionsTableTableViewCell
//
//            cell.cellLabelTest.text = arrayOfCellData[indexPath.row].text
//
//            return cell
//        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        if arrayOfCellData[indexPath.row].cell == 1 {
//            return 73
//        }
//        else {
//            return 73
//        }
        
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
