//
//  TeamSumViewController.swift
//  FavSports
//
//  Created by Jorge Aguiniga on 5/2/16.
//  Copyright © 2016 CMPE 137. All rights reserved.
//

import UIKit



class TeamSumViewController: UIViewController, UIScrollViewDelegate {

    private var message: String = ""
    var toRecieve: String = ""
    var teamSummary = [String: (String, String)]()
    var names = ["Arsenal", "Chelsea","Leicester City","Liverpool", "Manchester City", "Manchester United","Tottenham Hotspur"]
    
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var Name: UILabel!
   
   
    @IBOutlet weak var TeamLogo: UIImageView!
    
    
    @IBOutlet weak var Nickname: UILabel!
    
    
    @IBOutlet weak var Established: UILabel!
    
    
    @IBOutlet weak var nname: UILabel!
    
    
    @IBOutlet weak var year: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        self.scrollView.minimumZoomScale = 1.0
        
        self.scrollView.maximumZoomScale = 5.0
        
        
        message = toRecieve
        Name.text = message
        
        if teamSummary.isEmpty {
            CLUBS_REF.observeEventType(.Value, withBlock: { snapshot in
                var teams = [String: (String, String)]()
                var counter = 0
                for team in snapshot.children {
                    let name = team.value["Nickname"] as! String
                    let year = team.value["Year"] as! String
                    print("adding name: \(name) and year \(year) to \(self.names[counter])")
                    teams[self.names[counter]] = (name, year)
                    counter += 1
                }
                self.teamSummary = teams
                self.viewDidLoad()
            })
        }
        print("Nicknames: ")
        for (name, year) in teamSummary{
            
            print("team nickname: \(name) and year established \(year)")
        }
        TeamLogo.image = UIImage(named: teamInfo[message]!.2)
        Name.textColor = UIColor.whiteColor()
        if(!teamSummary.isEmpty){
            nname.text = teamSummary[message]?.0
            nname.textColor = teamInfo[message]?.0
            year.text = teamSummary[message]?.1
            year.textColor = teamInfo[message]?.0
        }
        Nickname.textColor = teamInfo[message]?.0
        Established.textColor = teamInfo[message]?.0
        self.view.backgroundColor = teamInfo[message]?.1

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.TeamLogo
    }
    
    @IBAction func addToFaves(sender: UIButton) {
        USER_REF.childByAppendingPath(message).setValue(true)

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
