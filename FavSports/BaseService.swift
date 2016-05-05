//
//  BaseService.swift
//  FavSports
//
//  Created by Jay Bajaj on 4/25/16.
//  Copyright © 2016 CMPE 137. All rights reserved.
//

import Foundation
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase

let BASE_URL = "https://favesports.firebaseio.com"

let FIREBASE_REF = Firebase(url:BASE_URL)
let CLUBS_REF = Firebase(url:"https://favesports.firebaseio.com/Clubs")
//let PLAYER_REF =
//let SPORTS_REF =
let FAVES_REF = Firebase(url:"https://favesports.firebaseio.com/Faves")
let USER_REF = FAVES_REF.childByAppendingPath(CURRENT_USER_UID)
let PLAYERS_REF = Firebase(url:"https://favesports.firebaseio.com/Players")
let VENUE_REF = Firebase(url: "https://favesports.firebaseio.com/Stadium")
let MANAGER_REF = Firebase(url: "https://favesports.firebaseio.com/Manager")
let FIXTURE_REF = Firebase(url: "https://favesports.firebaseio.com/Fixtures")

var CURRENT_USER: Firebase{ // save unique identifier for user that is logged in when authinticated
    let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String

    let current_user = Firebase(url: "\(FIREBASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
    
    return current_user
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
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

var teamInfo = [String: (UIColor, UIColor, String)]()
let Arsenal = (ArseGold, ArseBlue, "Arsenal")
let Chelsea = (ChelsBlue, ChelsRed, "chelsea")
let LeicesterCity = (ChelsBlue, LeicYellow, "LeicesterCityLogo")
let Liverpool = (LivRed, LivCyan, "LiverpoolLogo")
let ManchesterCity = (ManCGold, ManCLightBlue, "ManchesterCity")
let ManchesterUnited = (ChelsRed, ManUYellow, "ManchesterUnited")
let TottenhamHotspur = (ArseBlue, UIColor.whiteColor(), "Hotspur")


    func initializeTeamInfo()
    {
        teamInfo["Arsenal"] = Arsenal
        teamInfo["Chelsea"] = Chelsea
        teamInfo["Leicester City"] = LeicesterCity
        teamInfo["Liverpool"] = Liverpool
        teamInfo["Manchester City"] = ManchesterCity
        teamInfo["Manchester United"] = ManchesterUnited
        teamInfo["Tottenham Hotspur"] = TottenhamHotspur        
}


var CURRENT_USER_UID: String = ""
var SELECTED_TEAM: String = ""

