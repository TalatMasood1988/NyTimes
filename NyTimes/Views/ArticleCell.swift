//
//  ArticleCell.swift
//  NyTimes
//
//  Created by Maseeh Ahmed on 5/15/19.
//  Copyright © 2019 talat. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblPublishedBy: UILabel!
    @IBOutlet var imgThumbnail: UIImageView!
    @IBOutlet var lblPublishedDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
