//
//  LogoutViewController.swift
//  FavSports
//
//  Created by Jay Bajaj on 5/5/16.
//  Copyright © 2016 CMPE 137. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class LogoutViewController: UITabBarController {

    @IBAction func logoutAction(sender: AnyObject) {
            if FBSDKAccessToken.currentAccessToken()==nil {
                CURRENT_USER.unauth()
            }
            else {
                let loginManager = FBSDKLoginManager()
                
                loginManager.logOut()
            }
            
            self.performSegueWithIdentifier("showLoginLogout", sender: self)
            print("Log out complete")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
