//
//  EditChannelViewController.swift
//  Connnect
//
//  Created by Stella Su on 11/19/16.
//  Copyright © 2016 iOS-Connect. All rights reserved.
//

import UIKit

class EditChannelViewController: UIViewController {
    
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var newButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        joinButton.backgroundColor = .clear
        joinButton.layer.cornerRadius = 10
        joinButton.layer.borderWidth = 2
        joinButton.layer.borderColor = self.view.tintColor.cgColor
        
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
