//
//  LoginViewController.swift
//  FavSports
//
//  Created by Jay Bajaj on 4/25/16.
//  Copyright © 2016 CMPE 137. All rights reserved.
//

//test

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fbLoginButton = FBSDKLoginButton()
        fbLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
        fbLoginButton.center=self.view.center
        fbLoginButton.delegate = self
        self.view.addSubview(fbLoginButton)
    // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if(FBSDKAccessToken.currentAccessToken()==nil){
            
        }
        else{
            self.view.hidden = true
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if(FBSDKAccessToken.currentAccessToken()==nil){
            print("Not logged in")
        }
        else{
            
            let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
            FIREBASE_REF.authWithOAuthProvider("facebook", token: accessToken,
                                               withCompletionBlock: { error, authData in
                                                CURRENT_USER_UID = authData.uid
            })
            self.performSegueWithIdentifier("showHome", sender: self)
            print("Logged In")
            
        }
        
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && CURRENT_USER.authData != nil{
         //self.LogoutButton.hidden = false
         }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error == nil {
            //FIREBASE_REF.childByAppendingPath("Faves")

            
            //self.performSegueWithIdentifier("showHome", sender: self)
            print("Log in complete")
            
            
        }
        else {
            //print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User logged out")
       
    }
    
    
    
    
    
    

    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    @IBAction func loginAction(sender: UIButton) {
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        
        if email != "" && password != ""
        {
            FIREBASE_REF.authUser(email, password: password, withCompletionBlock: { (error, authData)-> Void in
                if error == nil
                {
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKeyPath: "uid")
                    CURRENT_USER_UID = FIREBASE_REF.authData.uid
                    print("Logged in")
                   //FIREBASE_REF.childByAppendingPath("Faves")
                   self.performSegueWithIdentifier("showHome", sender: self)
                    
                }
                else{
                    print("error")
                }
                
            })
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Enter Email and Password", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
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
