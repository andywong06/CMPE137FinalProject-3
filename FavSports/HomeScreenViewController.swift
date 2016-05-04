//
//  HomeScreenViewController.swift
//  FavSports
//
//  Created by Alberto Reyes on 4/27/16.
//  Copyright © 2016 CMPE 137. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class HomeScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logout_button_clicked(sender: UIButton) {
        
        CURRENT_USER.unauth()
        
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        self.performSegueWithIdentifier("showLogin", sender: self)
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
