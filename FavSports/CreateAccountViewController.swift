//
//  CreateAccountViewController.swift
//  FavSports
//
//  Created by Jay Bajaj on 4/25/16.
//  Copyright © 2016 CMPE 137. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
  @IBAction func createAccountAction(sender: UIButton) {
    
    let email = self.emailTextField.text
    let password = self.passwordTextField.text
        
        if email != "" && password != ""
        {
            FIREBASE_REF.createUser( email, password: password, withValueCompletionBlock: { (error, authData)-> Void in
                
                if error == nil{
                    FIREBASE_REF.authUser(email, password: password, withCompletionBlock: { (error, authData)-> Void in
                        
                        if error==nil{
                            //NSUserDefaults.standardUserDefaults().setValue(authData, forKeyPath: "uid")
                            print("Account Created")
                            
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }
                        else {
                            print(error)
                        }
                    })
                }
                else{
                    print(error)
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


    @IBAction func cancelAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
