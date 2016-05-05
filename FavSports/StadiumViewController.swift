//
//  StadiumViewController.swift
//  FavSports
//
//  Created by Jorge Aguiniga on 5/3/16.
//  Copyright © 2016 CMPE 137. All rights reserved.
//

import UIKit
import Firebase

class StadiumViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var venueTextBox: UITextView!
    
    @IBOutlet weak var addressTextBox: UITextView!
    
    @IBOutlet weak var builtLabel: UILabel!
    
    @IBOutlet weak var capacityLabel: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //imageView.image = UIImage(named: "search")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        venueTextBox.textColor = teamInfo[SELECTED_TEAM]?.0
        addressTextBox.textColor = teamInfo[SELECTED_TEAM]?.0
        builtLabel.textColor = teamInfo[SELECTED_TEAM]?.0
        capacityLabel.textColor = teamInfo[SELECTED_TEAM]?.0
        self.view.backgroundColor = teamInfo[SELECTED_TEAM]?.1
        
        if (SELECTED_TEAM == "Arsenal") {
            imageView.image = UIImage(named: "arsenal_ven")
        }
        else if (SELECTED_TEAM == "Chelsea"){
            imageView.image = UIImage(named: "chelsea_ven")
        }
        else if (SELECTED_TEAM == "Leicester City"){
            imageView.image = UIImage(named: "leicester_ven")
        }
        else if (SELECTED_TEAM == "Liverpool"){
            imageView.image = UIImage(named: "liverpool_ven")
        }
        else if (SELECTED_TEAM == "Manchester City"){
            imageView.image = UIImage(named: "man_city_ven")
        }
        else if (SELECTED_TEAM == "Manchester United"){
            imageView.image = UIImage(named: "man_united_ven")
        }
        else if (SELECTED_TEAM == "Tottenham Hotspur"){
            imageView.image = UIImage(named: "tottenham_ven")
        }
        
        let team_ref = VENUE_REF.childByAppendingPath(SELECTED_TEAM)
        team_ref.observeEventType(.Value, withBlock: { snapshot in
            self.venueTextBox.text = snapshot.value["Name"] as! String
            self.addressTextBox.text = snapshot.value["Address"] as! String
            self.builtLabel.text = "Built: \(snapshot.value["Built"] as! Int)"
            self.capacityLabel.text = "Capacity: \(snapshot.value["Capacity"] as! String)"
            print(snapshot.value["Name"])
        })
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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
