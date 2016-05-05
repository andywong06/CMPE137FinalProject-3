//
//  StatsViewController.swift
//  FavSports
//
//  Created by Jorge Aguiniga on 5/3/16.
//  Copyright © 2016 CMPE 137. All rights reserved.
//

import UIKit
import Firebase

class StatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellIdentifier = "CellIdentifierStatMain"
    
    @IBOutlet weak var tableView: UITableView!
    
    var categorizedTeams = [String: [String]]()
    
    var faveTeams = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.backgroundColor = teamInfo[SELECTED_TEAM]?.1
        self.view.backgroundColor = teamInfo[SELECTED_TEAM]?.1
        
        faveTeams = []
        //CLUBS_REF.queryOrderedByChild("Match Stats/Points")
        
        CLUBS_REF.queryOrderedByChild("Match Stats/Points").observeEventType(.Value, withBlock: { snapshot in
            for item in (snapshot.children).reverse() {
                let child = item.childSnapshotForPath("Match Stats")
                let stats = "P: \(child.value["Played"] as! Int)    | W: \(child.value["Won"] as! Int) | D: \(child.value["Drawn"] as! Int) | L: \(child.value["Lost"] as! Int) |     Pts: \(child.value["Points"] as! Int)"
                self.faveTeams.append(item.key)
                self.faveTeams.append(stats)
                self.categorizedTeams = self.categorize(self.faveTeams)
                self.tableView.reloadData()
            }
        })
        
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
    var set = false;
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
            cell.backgroundColor = teamInfo[SELECTED_TEAM]?.1
            if (team == SELECTED_TEAM || set) {
                cell.textLabel?.textColor = teamInfo[SELECTED_TEAM]?.0
                set = true
                if (set && team != SELECTED_TEAM) {
                    set = false
                }
                
            }
            else {
                if (SELECTED_TEAM == "Arsenal") {
                    cell.textLabel?.textColor = UIColor.whiteColor()
                }
                else {
                    cell.textLabel?.textColor = UIColor.blackColor()
                }
                
            }
            
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
            if result["Stats and Rankings"] != nil{
                result["Stats and Rankings"]!.append(item)
                
            }
            else{
                result["Stats and Rankings"] = [item]
            }
        }
        return result
    }
    
    
    var faves = [String]()
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if let view = view as? UITableViewHeaderFooterView {
            view.textLabel!.backgroundColor = UIColor.clearColor()
            view.textLabel!.textColor = UIColor.whiteColor()
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
