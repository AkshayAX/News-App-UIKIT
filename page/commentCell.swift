//
//  commentCell.swift
//  page
//
//  Created by Akshaya Kumar N on 2/16/20.
//  Copyright © 2020 Akshaya Kumar N. All rights reserved.
//

import UIKit

class commentCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        comment.sizeToFit()
    }
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var comment: UILabel!
   

}
