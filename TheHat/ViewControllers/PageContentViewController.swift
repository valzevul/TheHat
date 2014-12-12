//
//  PageContentViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 9/11/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

/// Class for the content of tutorial pages.
class PageContentViewController: BaseViewController {
    
    /// Page label
    @IBOutlet weak var titleLabel: UILabel!
    
    /// Page description
    @IBOutlet weak var descriptionLabel: UILabel!
    
    /// Background image
    @IBOutlet weak var backgroundImage: UIImageView!
    
    /// Curent page index
    var pageIndex: Int?
    
    /// View controller title
    var titleText: String?
    
    /// View controller description
    var descriptionText: String?
    
    /// Image file
    var imageFile: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Multiline-support
        descriptionLabel!.lineBreakMode = .ByWordWrapping
        descriptionLabel!.numberOfLines = 0
        
        if (imageFile != nil) {
            self.backgroundImage.image = imageFile
        }
        if (titleText != nil) {
            self.titleLabel.text = titleText
        }
        if (descriptionText != nil) {
            self.descriptionLabel.text = descriptionText
        }
    }
}
