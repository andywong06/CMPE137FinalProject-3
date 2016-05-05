//
//  ManagerViewController.swift
//  FavSports
//
//  Created by Jay Bajaj on 5/5/16.
//  Copyright © 2016 CMPE 137. All rights reserved.
//

import UIKit

class ManagerViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    
    @IBOutlet weak var placeOfBirthLabel: UILabel!
    
    @IBOutlet weak var winPercantage: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if (SELECTED_TEAM == "Arsenal") {
            imageView.image = UIImage(named: "arsene_wenger")
        }
        else if (SELECTED_TEAM == "Chelsea"){
            imageView.image = UIImage(named: "guus_hiddink")
        }
        else if (SELECTED_TEAM == "Leicester City"){
            imageView.image = UIImage(named: "claudio_ranieri")
        }
        else if (SELECTED_TEAM == "Liverpool"){
            imageView.image = UIImage(named: "jurgen_klopp")
        }
        else if (SELECTED_TEAM == "Manchester City"){
            imageView.image = UIImage(named: "manuel_pellegrini")
        }
        else if (SELECTED_TEAM == "Manchester United"){
            imageView.image = UIImage(named: "louis_van_gaal")
        }
        else if (SELECTED_TEAM == "Tottenham Hotspur"){
            imageView.image = UIImage(named: "mauricio_pochettino")
        }
        
        nameLabel.textColor = teamInfo[SELECTED_TEAM]?.0
        dateOfBirthLabel.textColor = teamInfo[SELECTED_TEAM]?.0
        placeOfBirthLabel.textColor = teamInfo[SELECTED_TEAM]?.0
        winPercantage.textColor = teamInfo[SELECTED_TEAM]?.0
        self.view.backgroundColor = teamInfo[SELECTED_TEAM]?.1
        


        let team_ref = MANAGER_REF.childByAppendingPath(SELECTED_TEAM)
        team_ref.observeEventType(.Value, withBlock: { snapshot in
            self.nameLabel.text = snapshot.value["name"] as! String
            self.dateOfBirthLabel.text =  self.dateOfBirthLabel.text! + " \(snapshot.value["date of birth"] as! String)"
            self.placeOfBirthLabel.text = self.placeOfBirthLabel.text! + " \(snapshot.value["country of birth"] as! String)"
            self.winPercantage.text = self.winPercantage.text! + " \(snapshot.value["win %"] as! String)"
            print(snapshot.value["name"])
        })
        
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
