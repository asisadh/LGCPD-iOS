//
//  SMListTableViewCell.swift
//  LGCPD
//
//  Created by Aashish Adhikari on 12/8/16.
//  Copyright © 2016 Aashish Adhikari. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phoneNo: UILabel!
    @IBOutlet weak var vdc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
