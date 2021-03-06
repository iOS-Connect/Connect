//
//  RoundedButton.swift
//  Connnect
//
//  Created by Stella Su on 11/22/16.
//  Copyright © 2016 iOS-Connect. All rights reserved.
//

import UIKit

class RoundedButton: UIButton{
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureRoundedCorners()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureRoundedCorners()
    }

    private func configureRoundedCorners() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = self.tintColor.cgColor
    }
}
