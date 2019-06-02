//
//  SettingsTableViewCell.swift
//  Tapchainex
//
//  Created by admin on 12/3/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subtitleLbl: UILabel!
    
    let screen = UIScreen.main.bounds
    
    
    var accessoryButton: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryType = .disclosureIndicator
        accessoryButton = subviews.compactMap { $0 as? UIButton }.first
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
