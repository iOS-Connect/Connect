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

     
    }

    @IBAction func newChannel(sender: UIButton) {
        guard let newChannelName = joinTextField.text else { return }

        AppDelegate.shared.client.subscribe(toChannels: [newChannelName], withPresence: true)
        var current = (UserDefaults.standard.array(forKey: channelKey) ?? [Any]()) as? [String]
        if current == nil {
            current = [String]()
        }
        current!.append(newChannelName)
        UserDefaults.standard.set(current!, forKey: channelKey)
        AppDelegate.shared.openMainViewController()
    }

}
