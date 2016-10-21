//
//  SettingsViewController.swift
//  GithubDemo
//
//  Created by Edwin Wong on 10/21/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var settings:GithubRepoSearchSettings?
    var prevSettings:GithubRepoSearchSettings?
    var minStars:Int = 0
    
    @IBOutlet weak var minimumStarsSlider: UISlider!
    @IBOutlet weak var minStarsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        prevSettings = settings?.copy()
        
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
    
    @IBAction func onSave(_ sender: UIBarButtonItem) {
        // update settings variable
        settings?.minStars = minStars
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancel(_ sender: UIBarButtonItem) {
        // revert settings to previous copy
        self.settings = prevSettings?.copy()
        self.prevSettings = nil
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
