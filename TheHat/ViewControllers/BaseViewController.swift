//
//  BaseViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 16/11/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

/// Base class for global changes
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Constants.lightGrey // Global background colour
    }
    
}
