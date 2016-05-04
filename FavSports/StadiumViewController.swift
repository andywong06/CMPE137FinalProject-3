//
//  StadiumViewController.swift
//  FavSports
//
//  Created by Jorge Aguiniga on 5/3/16.
//  Copyright © 2016 CMPE 137. All rights reserved.
//

import UIKit

class StadiumViewController: UIViewController {

    @IBOutlet weak var venueName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addressTextBox: UITextView!
    @IBOutlet weak var builtLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    
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
