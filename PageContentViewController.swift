//
//  PageContentViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 9/11/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var pageIndex: Int?
    var titleText: String?
    var imageFile: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (imageFile != nil) {
            self.backgroundImage.image = imageFile
        }
        if (titleText != nil) {
            self.titleLabel.text = titleText
        }
    }
}
