//
//  ViewController.swift
//  UAsk
//
//  Created by Megan Farleigh on 22/5/19.
//  Copyright © 2019 Megan Farleigh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBAction func buttonLogin(_ sender: Any) {
        
        self.performSegue(withIdentifier: "QuestionTransition", sender: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // test 3
        // olivia test
        // megan comment 

        // Do any additional setup after loading the view, typically from a nib.
    }


}

