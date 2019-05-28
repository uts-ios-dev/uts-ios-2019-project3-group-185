//
//  MyQuestionsTableTableViewController.swift
//  UAsk
//
//  Created by William Hong on 29/5/19.
//  Copyright © 2019 Megan Farleigh. All rights reserved.
//

import UIKit

class MyQuestionsTableTableViewController: UITableViewController {
        
    var arrayOfCellData = [cellData]()
    
    override func viewDidLoad() {
        
        arrayOfCellData = [cellData(cell: 1, text: "My Will"),cellData(cell: 2, text: "My Oliv"),cellData(cell: 3, text: "My Meg")]
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCellData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if arrayOfCellData[indexPath.row].cell == 1 {
            let cell = Bundle.main.loadNibNamed("MyQuestionsTableViewCell", owner: self, options: nil)?.first as! MyQuestionsTableViewCell
            
            cell.myQuestionLabel.text = arrayOfCellData[indexPath.row].text
            
            return cell
            
        }
        else {
            let cell = Bundle.main.loadNibNamed("MyQuestionsTableViewCell", owner: self, options: nil)?.first as! MyQuestionsTableViewCell
            
            cell.myQuestionLabel.text = arrayOfCellData[indexPath.row].text
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if arrayOfCellData[indexPath.row].cell == 1 {
            return 73
        }
        else {
            return 73
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController : String
        switch indexPath.row {
        case 0: //For "one"
            viewController = "MyAnswersViewController"
        case 1: //For "two"
            viewController = "LoginViewController"
        default: //For "three"
            viewController = "MyAnswersViewController"
        }
        
        let privateAnswersViewController = storyboard.instantiateViewController(withIdentifier: viewController)
        
        self.present(privateAnswersViewController, animated:true, completion: nil)
    }
    
}
