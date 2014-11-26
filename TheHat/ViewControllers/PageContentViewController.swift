//
//  PageContentViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 9/11/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

/// Class for the content of tutorial pages.
class PageContentViewController: UIViewController {
    
    /// Page label
    @IBOutlet weak var titleLabel: UILabel!
    
    /// Background image
    @IBOutlet weak var backgroundImage: UIImageView!
    
    /// Curent page index
    var pageIndex: Int?
    
    /// View controller title
    var titleText: String?
    
    /// Image file
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
