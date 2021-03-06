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
    
    @IBAction func newChannel(sender: UIButton) {
        guard let newChannelName = newTextField.text else { return }
        
        guard newChannelName != ""
            else { return }

        AppDelegate.shared.client.subscribe(
            toChannels: [newChannelName], withPresence: true)
        var current = (UserDefaults.standard.array(forKey: channelKey) ?? [Any]()) as? [String]
        if current == nil {
            current = [String]()
        }
        current!.append(newChannelName)
        UserDefaults.standard.set(current!, forKey: channelKey)
        AppDelegate.shared.openMainViewController()
    }

}
