//
//  ModalSettingsViewControllerDelegate.swift
//  GithubDemo
//
//  Created by Edwin Wong on 10/21/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import Foundation

protocol ModalSettingsViewControllerDelegate: class{
    func sendValue(settings: GithubRepoSearchSettings)
}
