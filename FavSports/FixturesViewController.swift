//
//  FixturesViewController.swift
//  FavSports
//
//  Created by Alberto Reyes on 5/5/16.
//  Copyright © 2016 CMPE 137. All rights reserved.
//

import UIKit
import Firebase

class FixturesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var lastSix: [String] = []
    var upcomingGames: [String] = []
    
    let cellID = "fixture"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = teamInfo[SELECTED_TEAM]?.1
        self.view.backgroundColor = teamInfo[SELECTED_TEAM]?.1
        if lastSix.isEmpty {

        FIXTURE_REF.observeEventType(.Value, withBlock: { snapshot in
            self.lastSix = []
            self.upcomingGames = []
            let team = snapshot.childSnapshotForPath(SELECTED_TEAM)
            let previousGames = team.childSnapshotForPath("Last 6")
            for match in previousGames.children {
                 let gameInfo = "Date: \(match.value["Date"] as! String)        Score: \(match.value["Score"] as! String)\nOpponent: \(match.value["Team Against"] as! String)"
                    self.lastSix.append(gameInfo)
                }
            let upcomingGames = team.childSnapshotForPath("Next 6")
            
            for match in upcomingGames.children {
                let gameInfo = "Date: \(match.value["Date"] as! String)     Score: \(match.value["Score"] as! String)\nOpponent: \(match.value["Team Against"] as! String)"
                self.upcomingGames.append(gameInfo)
            }

            self.tableView.reloadData()
        })
        }
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Only 2 sections in table: Last Six Games and Next Six Games
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    //Each section has 6 rows. 1 for each game
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return lastSix.count
        }
        else {
            return upcomingGames.count
        }
    }
    //data for each cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath)
        var game = ""
        let previousOrNext = indexPath.section
       
        if previousOrNext == 0 {
            game = lastSix[indexPath.row]
        }
        else {
            game = upcomingGames[indexPath.row]
        }
        cell.textLabel?.text = game
        cell.textLabel?.textColor = teamInfo[SELECTED_TEAM]?.0
        cell.textLabel?.numberOfLines = 0
        cell.backgroundColor = teamInfo[SELECTED_TEAM]?.1
        
        return cell
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sections = ["Previous Six", "Upcoming Games"]
        return sections[section]
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
