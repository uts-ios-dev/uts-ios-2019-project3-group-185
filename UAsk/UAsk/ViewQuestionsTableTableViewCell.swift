//
//  ViewQuestionsTableTableViewCell.swift
//  UAsk
//
//  Created by William Hong on 27/5/19.
//  Copyright © 2019 Megan Farleigh. All rights reserved.
//

import UIKit


class ViewQuestionsTableTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabelTest: UILabel!
    @IBOutlet weak var cellLabelContent: UILabel!
    @IBOutlet weak var cardView: UIImageView!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func ViewQuestionsTableTableViewCellContent() {
//        cellLabelContent.sizeToFit()
//    }
    
}
