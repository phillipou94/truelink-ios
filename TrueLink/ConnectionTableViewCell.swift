//
//  ConnectionTableViewCell.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/16/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import UIKit

class ConnectionTableViewCell: UITableViewCell {

    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var connectionTypeLabel: UILabel!
    @IBOutlet weak var connectionTypeImageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoLabel: UILabel!
    var logoColor = UIColor.TLSpecialBlue()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.logoLabel.textColor = UIColor.white
        self.profileView.backgroundColor = self.logoColor
        
        self.profileView.makeCircular()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
