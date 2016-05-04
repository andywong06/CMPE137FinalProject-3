//
//  TeamSumViewController.swift
//  FavSports
//
//  Created by Jorge Aguiniga on 5/2/16.
//  Copyright © 2016 CMPE 137. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
class TeamSumViewController: UIViewController {

    private var message: String = ""
    var toRecieve: String = ""
    
    let ArseGold = UIColor(red: 201, green: 166, blue: 26)
    let ArseBlue = UIColor(red: 0, green: 0, blue: 102)
    
    let ChelsBlue = UIColor(red: 26, green: 1, blue: 201)
    let ChelsRed = UIColor(red:255, green: 0, blue: 0)
    //use ArseGold for chelse
    
    //use ChelseBlue for LeicBlue
    let LeicYellow = UIColor(red: 255, green: 235, blue: 62)
    
    let LivRed = UIColor(red: 204, green: 0, blue: 0)
    let LivCyan = UIColor(red: 0, green: 153, blue: 153)
    
    let ManCGold = UIColor(red: 250, green: 221, blue: 75)
    let ManCLightBlue = UIColor(red: 51, green: 153, blue: 255)
    
    //Use ChelsRed for ManURed
    let ManUYellow = UIColor(red: 255, green: 237, blue: 65)
    
    //Use ArseBlue for TottBlue
    
    
    @IBOutlet weak var Name: UILabel!
   
   
    @IBOutlet weak var TeamLogo: UIImageView!
    
    
    @IBOutlet weak var Nickname: UILabel!
    
    
    @IBOutlet weak var Established: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        message = toRecieve
        Name.text = message
        
        TeamLogo.image = UIImage(named: "Hotspur.png")
        Name.textColor = UIColor.whiteColor()
        Nickname.textColor = UIColor.redColor()
        Established.textColor = ArseGold
       self.view.backgroundColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
