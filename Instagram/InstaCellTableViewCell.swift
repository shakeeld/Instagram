//
//  InstaCellTableViewCell.swift
//  Instagram
//
//  Created by Shakeel Daswani on 3/20/16.
//  Copyright © 2016 shakeeld. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class InstaCellTableViewCell: UITableViewCell {
   

    @IBOutlet weak var captionStuff: UILabel!
    @IBOutlet weak var photoView: PFImageView!
    
    var instagramPost: PFObject! {
        didSet {
            self.photoView.file = instagramPost["media"] as? PFFile
            self.captionStuff.text = instagramPost["caption"] as? String
            self.photoView.loadInBackground()
        }
    }
    

    
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
