//
//  TabBarmoreViewController.swift
//  FavSports
//
//  Created by Jay Bajaj on 5/12/16.
//  Copyright © 2016 CMPE 137. All rights reserved.
//

import UIKit

class TabBarmoreViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor .whiteColor()
        if(SELECTED_TEAM == "Manchester City" || SELECTED_TEAM == "Arsenal"){
            self.tabBar.tintColor = teamInfo[SELECTED_TEAM]?.1
        }
        else{
            self.tabBar.tintColor = teamInfo[SELECTED_TEAM]?.0
        }
        if let moreTableView = moreNavigationController.topViewController?.view as? UITableView {
            moreTableView.tintColor = teamInfo[SELECTED_TEAM]?.0
            moreTableView.backgroundColor = teamInfo[SELECTED_TEAM]?.1
        }
        
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
