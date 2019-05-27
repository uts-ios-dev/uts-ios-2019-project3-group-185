//
//  ViewQuestionsTableViewController.swift
//  UAsk
//
//  Created by William Hong on 27/5/19.
//  Copyright © 2019 Megan Farleigh. All rights reserved.
//

import UIKit

struct cellData{
    let cell : Int!
    let text : String!
    //  let image : UIImage!
}

class ViewQuestionsTableViewController: UITableViewController {
        
    var arrayOfCellData = [cellData]()
    
    override func viewDidLoad() {
        
        arrayOfCellData = [cellData(cell: 1, text: "Will"),cellData(cell: 2, text: "Oliv"),cellData(cell: 3, text: "Meg")]
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCellData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if arrayOfCellData[indexPath.row].cell == 1 {
            let cell = Bundle.main.loadNibNamed("ViewQuestionsTableTableViewCell", owner: self, options: nil)?.first as! ViewQuestionsTableTableViewCell
            
            cell.cellLabelTest.text = arrayOfCellData[indexPath.row].text
            
            return cell
            
        }
        else {
            let cell = Bundle.main.loadNibNamed("ViewQuestionsTableTableViewCell", owner: self, options: nil)?.first as! ViewQuestionsTableTableViewCell
            
            cell.cellLabelTest.text = arrayOfCellData[indexPath.row].text
            
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
    
}
