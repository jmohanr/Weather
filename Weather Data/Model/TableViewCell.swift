//
//  TableViewCell.swift
//  Weather Data
//
//  Created by Jagan on 11/02/20.
//  Copyright © 2020 Jagan. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dataLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
