//
//  JoinViewController.swift
//  Connnect
//
//  Created by Stella Su on 11/19/16.
//  Copyright © 2016 iOS-Connect. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController {

    @IBOutlet weak var joinTextField: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        joinButton.backgroundColor = .clear
        joinButton.layer.cornerRadius = 10
        joinButton.layer.borderWidth = 2
        joinButton.layer.borderColor = self.view.tintColor.cgColor

        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
