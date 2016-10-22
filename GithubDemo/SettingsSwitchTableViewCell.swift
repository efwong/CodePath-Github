//
//  SettingsSwitchTableViewCell.swift
//  GithubDemo
//
//  Created by Edwin Wong on 10/21/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class SettingsSwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var optionSwitch: UISwitch!
    
    weak var delegate: SettingsSwitchCellDelegate?
    
    var settingsRowIdentifier: LanguageSettings!{
        didSet{
            optionLabel?.text = settingsRowIdentifier?.rawValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // event for toggling switch
    @IBAction func didToggleSwitch(_ sender: AnyObject) {
        delegate?.settingsSwitchCellDidToggle(cell: self, newValue: optionSwitch.isOn)
    }
    
}
