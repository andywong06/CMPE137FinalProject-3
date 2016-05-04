//
//  BrowseTeamsViewController.swift
//  FavSports
//
//  Created by Alberto Reyes on 4/27/16.
//  Copyright © 2016 CMPE 137. All rights reserved.
//

import UIKit
import Firebase

class BrowseTeamsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellIdentifier = "CellIdentifier"
    
    var categorizedTeams = [String: [String]]()
    
    var teams = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        CLUBS_REF.observeEventType(.Value, withBlock: { snapshot in
            var newTeams = [String]()
            for team in snapshot.children {
                let name = team.value["name"] as! String
                newTeams.append(name)
            }
            self.teams = newTeams
            self.categorizedTeams = self.categorize(self.teams)
            self.tableView.reloadData()
        }) 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let keys = categorizedTeams.keys
        
        return keys.count
    }
    
    //Number of rows per section: the number of teams that will go in each sport category
    func tableView(tableView:UITableView, numberOfRowsInSection section: Int) -> Int {

        let keys = categorizedTeams.keys
        
        //sort keys
        let sortedKeys = keys.sort({ (a, b) -> Bool in
            a.lowercaseString < b.lowercaseString
        })
        
        
        //fetch teams
        let key = sortedKeys[section]
        
        if let teams = categorizedTeams[key]{
            return teams.count
        }
        return 0
    }

    //required methods for table protocol: tableView(_:cellForRowAtIndexPath:)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     
        //check if there was a table view already created in the reuse queue
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        // Fetch and Sort Keys
        let keys = categorizedTeams.keys.sort({ (a, b) -> Bool in
            a.lowercaseString < b.lowercaseString
        })
        
        // Fetch teams for Section
        let key = keys[indexPath.section]
        
        if let teams = categorizedTeams[key] {
            // Fetch team
            let team = teams[indexPath.row]
            
            // Configure Cell
            cell.textLabel?.text = team
        }
        
        
        return cell
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        

        // Fetch and Sort Keys
        let keys = categorizedTeams.keys.sort({ (a, b) -> Bool in
            a.lowercaseString < b.lowercaseString
        })
        
        return keys[section]
    }
    private func categorize(array: [String]) -> [String: [String]] {
        var result = [String: [String]]()
        for item in array{
            if result["Soccer"] != nil{
                result["Soccer"]!.append(item)
                
            }
            else{
                result["Soccer"] = [item]
            }
        }
        return result
    }
    
    
    var faves = [String]()
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var teamName : String
        teamName = teams[indexPath.row]
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        toggleCellCheckbox(cell, teamName: teamName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggleCellCheckbox(cell: UITableViewCell, teamName: String) {
        message = teamName
        self.performSegueWithIdentifier("showTeamSum", sender: self)
        
//        if cell.accessoryType ==  UITableViewCellAccessoryType.Checkmark {
//            cell.accessoryType = UITableViewCellAccessoryType.None
//            cell.textLabel?.textColor = UIColor.blackColor()
//            cell.detailTextLabel?.textColor = UIColor.blackColor()
//            let i = faves.indexOf(teamName)!
//            faves.removeAtIndex(i)
//        } else {
//            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
//            cell.textLabel?.textColor = UIColor.grayColor()
//            cell.detailTextLabel?.textColor = UIColor.grayColor()
//            faves.append(teamName)
//        }
    }
    var message = ""
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTeamSum" {
            let secondVC: TeamSumViewController = segue.destinationViewController as! TeamSumViewController
            secondVC.toRecieve = message
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
