//
//  TeamProfileViewController.swift
//  FavSports
//
//  Created by Andy Wong on 5/4/16.
//  Copyright © 2016 CMPE 137. All rights reserved.
//

import Foundation
import UIKit

class TeamProfileViewController : UIViewController{
    
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var teamLogo: UIImageView!
    
    @IBOutlet weak var teamStadium: UIImageView!

    
    @IBOutlet weak var teamEstablished: UILabel!
    
    @IBOutlet weak var stadium: UILabel!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var manager: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let team_ref = CLUBS_REF.childByAppendingPath(SELECTED_TEAM)
        team_ref.observeEventType(.Value, withBlock: { snapshot in
            self.teamEstablished.text = self.teamEstablished.text! + " \(snapshot.value["Year"] as! String)"
            self.stadium.text = self.stadium.text! + " \(snapshot.value["Stadium"] as! String)"
            self.nickName.text = self.nickName.text! +  " \(snapshot.value["Nickname"] as! String)"
            self.manager.text = self.manager.text! + " \(snapshot.value["Manager"] as! String)"
            
        })
        
        if (SELECTED_TEAM == "Arsenal"){
            teamName.text = SELECTED_TEAM
            teamLogo.image = UIImage (named: "Arsenal")
            teamStadium.image = UIImage (named: "arsenal_ven")
            
        }
        else if (SELECTED_TEAM == "Chelsea"){
            teamName.text = SELECTED_TEAM
            teamLogo.image = UIImage (named: "chelsea")
            teamStadium.image = UIImage (named: "chelsea_ven")
        }
        else if (SELECTED_TEAM == "Leicester City"){
            teamName.text = SELECTED_TEAM
            teamLogo.image = UIImage (named: "LeicesterCityLogo")
            teamStadium.image = UIImage (named: "leicester_ven")
        }
        else if (SELECTED_TEAM == "Liverpool"){
            teamName.text = SELECTED_TEAM
            teamLogo.image = UIImage (named: "LiverpoolLogo")
            teamStadium.image = UIImage (named: "liverpool_ven")
        }
        else if (SELECTED_TEAM == "Manchester City"){
            teamName.text = SELECTED_TEAM
            teamLogo.image = UIImage (named: "ManchesterCity")
            teamStadium.image = UIImage (named: "man_city_ven")
        }
        else if (SELECTED_TEAM == "Manchester United"){
            teamName.text = SELECTED_TEAM
            teamLogo.image = UIImage (named: "ManchesterUnited")
            teamStadium.image = UIImage (named: "man_united_ven")
        }
        else if (SELECTED_TEAM == "Tottenham Hotspur"){
            teamName.text = SELECTED_TEAM
            teamLogo.image = UIImage (named: "Hotspur")
            teamStadium.image = UIImage (named: "tottenham_ven")
        }
       
    }
    
 

  
    
    
}