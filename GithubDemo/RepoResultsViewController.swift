//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD
import AFNetworking

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo]!

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.repos = []
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension
        //self.tableView.rowHeight = 300
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
    }

    // Perform the search.
    fileprivate func doSearch() {
        // clear results
        self.repos.removeAll()
        
        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window
            for repo in newRepos {
                self.repos.append(repo)
                print(repo)
            }
            
            self.tableView.reloadData()
            
            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.repoViewCell", for: indexPath) as! RepoTableViewCell
        if indexPath.row < self.repos.count{
            let repo = self.repos[indexPath.row]
            cell.nameLabel.text = repo.name
            cell.forkCount.text = "\(repo.forks ?? 0)"
            cell.starCountLabel.text = "\(repo.stars ?? 0)"
            cell.descriptionLabel.text = repo.repoDescription
            cell.ownerLabel.text = repo.ownerHandle
            if let imageUrl = repo.ownerAvatarURL{
                cell.repoImageView?.setImageWith(URL(string: imageUrl)!, placeholderImage: UIImage(named: "placeholder"))
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="ShowSettingsModal"{
            
            if let navVC = segue.destination as? UINavigationController{
                if let destinationVC = navVC.viewControllers[0] as? SettingsViewController {
                    destinationVC.settings = searchSettings
                    //destinationVC.delegate = self
                }
            }
        }
    }
    
    @IBAction func saveSettings(segue: UIStoryboardSegue){
        if let modalVC = segue.source as? SettingsViewController{
            if let modalSettings = modalVC.saveAndReturnSettings(){
                self.searchSettings = modalSettings
                doSearch() // refresh search
            }
        }
    }
    
    @IBAction func cancelSettings(segue: UIStoryboardSegue){
        if let modalVC = segue.source as? SettingsViewController{
            modalVC.cancelSettings()
        }
    }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
