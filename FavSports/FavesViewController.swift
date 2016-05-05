//
//  FavesViewController.swift
//  FavSports
//
//  Created by Jorge Aguiniga on 5/3/16.
//  Copyright © 2016 CMPE 137. All rights reserved.
//

import Firebase
import UIKit

class FavesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellIdentifier = "CellIdentifier2"
    
    var categorizedTeams = [String: [String]]()
    
    var faveTeams = [String]()
    
    var DELETE_STATE = false
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var deleteButtton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTeamInfo()
    }
    

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        var ref = FIREBASE_REF.authData
        while (ref == nil) {
            ref = FIREBASE_REF.authData
        }
        print("Firebase authdata: \(ref)")
        DELETE_STATE = false
        deleteButtton.setTitle("Delete", forState: .Normal)
        faveTeams = []
        CURRENT_USER_UID = FIREBASE_REF.authData.uid
        let user_ref_local = FAVES_REF.childByAppendingPath(CURRENT_USER_UID)
        user_ref_local.observeEventType(.ChildAdded, withBlock: { snapshot in
            //var newTeams = [String]()
            let name = snapshot.key
            self.faveTeams.append(name)
            
            //self.faveTeams = newTeams
            self.categorizedTeams = self.categorize(self.faveTeams)
            self.tableView.reloadData()
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
            cell.textLabel?.textColor = UIColor.whiteColor()
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
            if result["Faves"] != nil{
                result["Faves"]!.append(item)
                
            }
            else{
                result["Faves"] = [item]
            }
        }
        return result
    }
    
    
    var faves = [String]()
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var teamName : String
        teamName = faveTeams[indexPath.row]
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        toggleCellCheckbox(cell, teamName: teamName)
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if let view = view as? UITableViewHeaderFooterView {
            view.textLabel!.backgroundColor = UIColor.clearColor()
            view.textLabel!.textColor = UIColor.whiteColor()
        }
        
    }
    
    var message:String = ""
    func toggleCellCheckbox(cell: UITableViewCell, teamName: String) {
        if (DELETE_STATE) {
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete \(teamName) from Faves?", preferredStyle: UIAlertControllerStyle.Alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: {action in self.deleteTeam(teamName)}))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
            
            // show the alert
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            SELECTED_TEAM = teamName
            self.performSegueWithIdentifier("showTeamProfile", sender: self)
        }
    }
    
    func deleteTeam(team: String) {
            USER_REF.childByAppendingPath(team).removeValue()
            faveTeams = []
            let uid = FIREBASE_REF.authData.uid
            let user_ref_local = FAVES_REF.childByAppendingPath(uid)
            user_ref_local.observeEventType(.ChildAdded, withBlock: { snapshot in
                //var newTeams = [String]()
                let name = snapshot.key
                self.faveTeams.append(name)
                
                //self.faveTeams = newTeams
                self.categorizedTeams = self.categorize(self.faveTeams)
                self.tableView.reloadData()
            })
            if (faveTeams.count < 2) {
                DELETE_STATE = false
                deleteButtton.setTitle("Delete", forState: .Normal)
            }
        
        
        

    }
    
    @IBAction func deleteButtonAction(sender: UIButton) {
        if (faveTeams.count < 2) {
            var error = ""
            if (faveTeams.count == 1) {
                error = "You can't delete any more. You must at least have one team in Faves."
            }
            else {
                error = "There are no teams in Faves to delete. You can select and add teams in Browse"
            }
            let alert = UIAlertController(title: "Delete Error", message: error, preferredStyle: UIAlertControllerStyle.Alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
            
            // show the alert
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        if DELETE_STATE {
            DELETE_STATE = false
            sender.setTitle("Delete", forState: .Normal)
        }
        else {
            DELETE_STATE = true
            sender.setTitle("Cancel", forState: .Normal)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //let secondVC: TeamSumViewController = segue.destinationViewController as! TeamSumViewController
        //secondVC.toRecieve = message
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
