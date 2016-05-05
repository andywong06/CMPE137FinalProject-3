//
//  PlayersInfoViewController.swift
//  FavSports
//
//  Created by Jay Bajaj on 5/3/16.
//  Copyright © 2016 CMPE 137. All rights reserved.
//

import UIKit
import Firebase

class PlayersInfoViewController: UIViewController {
    
    
    
    @IBOutlet weak var PlayerImage: UIImageView!
    
    @IBOutlet weak var playerAge: UIButton!
    
    @IBOutlet weak var playerGeo: UIButton!
    
    @IBOutlet weak var playerGoals: UIButton!
    
    @IBOutlet weak var playerPosition: UIButton!
    
    @IBOutlet weak var playerKit: UIButton!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var goalsLabel: UILabel!
    
    @IBOutlet weak var positionLabel: UILabel!
    
    @IBOutlet weak var kitLabel: UILabel!
    
    
    var name = ""
    
    var image  = UIImage()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        ageLabel.textColor = teamInfo[SELECTED_TEAM]?.0
        countryLabel.textColor = teamInfo[SELECTED_TEAM]?.0
        goalsLabel.textColor = teamInfo[SELECTED_TEAM]?.0
        positionLabel.textColor = teamInfo[SELECTED_TEAM]?.0
        kitLabel.textColor = teamInfo[SELECTED_TEAM]?.0
        playerAge.backgroundColor = teamInfo[SELECTED_TEAM]?.1
        playerAge.tintColor = teamInfo[SELECTED_TEAM]?.0
        playerGeo.backgroundColor = teamInfo[SELECTED_TEAM]?.1
        playerGeo.tintColor = teamInfo[SELECTED_TEAM]?.0
        playerGoals.backgroundColor = teamInfo[SELECTED_TEAM]?.1
        playerGoals.tintColor = teamInfo[SELECTED_TEAM]?.0
        playerPosition.backgroundColor = teamInfo[SELECTED_TEAM]?.1
        playerPosition.tintColor = teamInfo[SELECTED_TEAM]?.0
        playerAge.backgroundColor = teamInfo[SELECTED_TEAM]?.1
        playerAge.tintColor = teamInfo[SELECTED_TEAM]?.0
        playerKit.backgroundColor = teamInfo[SELECTED_TEAM]?.1
        playerKit.tintColor = teamInfo[SELECTED_TEAM]?.0
        self.view.backgroundColor = teamInfo[SELECTED_TEAM]?.1
        
        
        Firebase(url: "\(PLAYERS_REF)/\(SELECTED_TEAM)/\(name)").observeEventType(.Value, withBlock: { snapshot in
            print(snapshot)
            print(snapshot.value["Position"])
            print(snapshot.value["Age"])
            print(snapshot.value["Goals"])
            print(snapshot.value["Country"])
            print(snapshot.value["Kit"])
           self.playerPosition.setTitle("\(snapshot.value["Position"] as! String)", forState: .Normal)
            self.playerAge.setTitle("\(snapshot.value["Age"] as! Int)", forState: .Normal)
             self.playerGoals.setTitle("\(snapshot.value["Goals"] as! Int)", forState: .Normal)
             self.playerGeo.setTitle("\(snapshot.value["Country"] as! String)", forState: .Normal)
            self.playerKit.setTitle("\(snapshot.value["Kit Number"] as! Int)", forState: .Normal)
        })
    }
    
    
        /*PLAYERS_REF.observeEventType(.Value, withBlock: { snapshot in
            for player in snapshot.children {
               self.playerAge = player.value["Age"] as! String
               self.playerGeo = player.value["Country"] as! String
                self.playerGoals = player.value["Goals"] as! String
                self.playerPosition = player.value["Position"] as! String
            }
        })*/
        
        
        
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        self.PlayerImage.image = self.image
        // Do any additional setup after loading the view.
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
