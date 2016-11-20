//
//  NewChannelViewController.swift
//  Connnect
//
//  Created by Stella Su on 11/19/16.
//  Copyright © 2016 iOS-Connect. All rights reserved.
//

import UIKit

class NewChannelViewController: UIViewController {

    
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var newTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newButton.backgroundColor = .clear
        newButton.layer.cornerRadius = 10
        newButton.layer.borderWidth = 2
        newButton.layer.borderColor = self.view.tintColor.cgColor
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
