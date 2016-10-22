//
//  SettingsViewController.swift
//  GithubDemo
//
//  Created by Edwin Wong on 10/21/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingsSwitchCellDelegate {

    var settings:GithubRepoSearchSettings? // current settings property
    var prevSettings:GithubRepoSearchSettings? // initial settings property
    var minStars:Int = 0
    
    let tableStructure : [[LanguageSettings]] = [[.enableLanguagesOption], LanguageSettings.allLanguages]
    var languagesOnOff:[LanguageSettings: Bool] = [:]

    
    @IBOutlet weak var minimumStarsSlider: UISlider!
    @IBOutlet weak var minStarsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView() // hide footer
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // register nib cell
        self.tableView.register(UINib(nibName: "SettingsSwitchTableViewCell", bundle: nil), forCellReuseIdentifier: "com.settingsTableViewCell")
        // Do any additional setup after loading the view.
        // update table structure
        //self.tableStructure[1] = LanguageSettings.allLanguages
        // load all languages
        clearLanguagesSetting()
        languagesOnOff[.enableLanguagesOption] = false
        // when settings language contains at least one language, flip enabled to true
        // populate dictionary with languages from previous setting
        if settings?.languages != nil && (settings?.languages.count)! > 0{
            languagesOnOff[.enableLanguagesOption] = true
            for language in (settings?.languages)!{
                languagesOnOff[language] = true
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.prevSettings = self.settings // save previous setting
        
        minStars = (settings?.minStars)!
        minStarsLabel.text = "\(minStars)"
        minimumStarsSlider.setValue(Float(minStars), animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSlide(_ sender: UISlider) {
        minStars = Int(sender.value)
        minStarsLabel.text = "\(minStars)"
    }
    
    // save settings and return object
    func saveAndReturnSettings() -> GithubRepoSearchSettings?{
        settings?.minStars = minStars
        settings?.languages = []
        if languagesOnOff[.enableLanguagesOption]!{
            for (key,status) in languagesOnOff{
                if key != .enableLanguagesOption && status{
                    //settings?.languages.append("\(key)") // add languages filter into settings
                    settings?.languages.append(key)
                }
            }
        }
        
        return settings
    }
    
    // cancel settings
    func cancelSettings(){
        // revert settings to previous copy
        self.settings = self.prevSettings
        self.prevSettings = nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableStructure.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableStructure[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.settingsTableViewCell", for: indexPath) as! SettingsSwitchTableViewCell
        
        let settingsLanguageOptionIdentifier:LanguageSettings = tableStructure[indexPath.section][indexPath.row]
        cell.settingsRowIdentifier = settingsLanguageOptionIdentifier
        if languagesOnOff[settingsLanguageOptionIdentifier] != nil{
            cell.optionSwitch.setOn(languagesOnOff[settingsLanguageOptionIdentifier]!, animated: false)
        }
        
        if settingsLanguageOptionIdentifier != .enableLanguagesOption{
            if !languagesOnOff[.enableLanguagesOption]! { // if languages is turned off, hide all language cells
                cell.isHidden = true
            }
        }
            
        
        cell.delegate = self
        
        return cell
    }
    
    func settingsSwitchCellDidToggle(cell: SettingsSwitchTableViewCell, newValue: Bool){
        languagesOnOff[cell.settingsRowIdentifier] = newValue
        
        // reload table if current cell is the enable switch
        if cell.settingsRowIdentifier == .enableLanguagesOption {
            clearLanguagesSetting() // if enableLanguagesOption is false, clear all languages
            self.tableView.reloadData()
        }
    }
    
    // clear all languages
    // set them to false
    func clearLanguagesSetting(){
        for language in LanguageSettings.allLanguages{
            languagesOnOff[language] = false
        }
    }
    
//    @IBAction func onSave(_ sender: UIBarButtonItem) {
//        // update settings variable
//        settings?.minStars = minStars
//        if let settingsToSend = settings{
//            delegate?.sendValue(settings: settingsToSend)
//        }
//        dismiss(animated: true, completion: nil)
//    }
//    
//    @IBAction func onCancel(_ sender: UIBarButtonItem) {
//        // revert settings to previous copy
//        self.settings = self.prevSettings
//        self.prevSettings = nil
//        dismiss(animated: true, completion: nil)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
