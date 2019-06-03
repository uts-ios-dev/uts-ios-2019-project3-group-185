//
//  MyQuestionsTableViewCell.swift
//  UAsk
//
//  Created by William Hong on 29/5/19.
//  Copyright © 2019 Megan Farleigh. All rights reserved.
//

import UIKit

class MyQuestionsTableViewCell: UITableViewCell {

 
    @IBOutlet weak var myQuestionLabel: UILabel!
    @IBOutlet weak var myQuestionsContent: UILabel!
    @IBOutlet weak var cellBackground: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
