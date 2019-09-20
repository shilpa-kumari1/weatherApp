//
//  FiveDayTableCellTableViewCell.swift
//  weatherApp
//
//  Created by Shilpa Kumari on 12/09/19.
//  Copyright © 2019 Shilpa Kumari. All rights reserved.
//

import UIKit

class FiveDayTableCellTableViewCell: UITableViewCell {

    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configureCell(table : [[String]],indexPath : IndexPath){
        dayLabel.text = table[0][indexPath.row]
        minTempLabel.text = table[1][indexPath.row]
        maxTempLabel.text = table[2][indexPath.row]
    }
    
}
