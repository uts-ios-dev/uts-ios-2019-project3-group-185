//
//  QuestionViewController.swift
//  UAsk
//
//  Created by William Hong on 22/5/19.
//  Copyright © 2019 Megan Farleigh. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    
    
    @IBOutlet weak var fragment: UIScrollView!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        var viewQuestionsViewController : ViewQuestionsViewController = ViewQuestionsViewController(nibName: "ViewQuestionsViewController", bundle: nil)
        
        var answerQuestionsViewController : AnswerQuestionsViewController = AnswerQuestionsViewController(nibName: "AnswerQuestionsViewController", bundle: nil)
        
        var myQuestionsViewController : MyQuestionsViewController = MyQuestionsViewController(nibName: "MyQuestionsViewController", bundle: nil)
        
        self.addChild(viewQuestionsViewController)
        self.fragment.addSubview(viewQuestionsViewController.view)
        viewQuestionsViewController.didMove(toParent: self)
        
        self.addChild(answerQuestionsViewController)
        self.fragment.addSubview(answerQuestionsViewController.view)
        answerQuestionsViewController.didMove(toParent: self)
        
        self.addChild(myQuestionsViewController)
        self.fragment.addSubview(myQuestionsViewController.view)
        myQuestionsViewController.didMove(toParent: self)
        
        var answerQuestionsViewControllerFragment : CGRect = answerQuestionsViewController.view.frame
        answerQuestionsViewControllerFragment.origin.x = self.view.frame.width
        answerQuestionsViewController.view.frame = answerQuestionsViewControllerFragment
        
        var myQuestionsViewControllerFragment : CGRect = myQuestionsViewController.view.frame
        myQuestionsViewControllerFragment.origin.x = 2 * self.view.frame.width
        myQuestionsViewController.view.frame = myQuestionsViewControllerFragment
        
        self.fragment.contentSize = CGSize(width: self.view.frame.width * 3, height: self.view.frame.size.height)
        
        
    }
    

}