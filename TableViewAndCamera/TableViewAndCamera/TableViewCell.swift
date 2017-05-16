//
//  TableViewCell.swift
//  TableViewAndCamera
//
//  Created by Cid Hsieh on 2017/5/16.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var myImageView: UIImageView!

    @IBOutlet weak var myLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
