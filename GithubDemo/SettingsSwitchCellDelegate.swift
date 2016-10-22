//
//  SettingsSwitchCellDelegate.swift
//  GithubDemo
//
//  Created by Edwin Wong on 10/22/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import Foundation

protocol SettingsSwitchCellDelegate: class{
    func settingsSwitchCellDidToggle(cell: SettingsSwitchTableViewCell, newValue: Bool)
}
