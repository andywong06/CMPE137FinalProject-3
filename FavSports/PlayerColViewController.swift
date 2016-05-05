//
//  PlayerColViewController.swift
//  FavSports
//
//  Created by Jay Bajaj on 5/3/16.
//  Copyright © 2016 CMPE 137. All rights reserved.
//

import UIKit
import Firebase

class PlayerColViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
  
    let reuseIdentifier = "cell"
    var playerNames =  [String]()
    
    var playerImageArray = [UIImage?]()
    
    
    @IBOutlet weak var playerCollection: UICollectionView!
    
    func teamselector(){
        if(SELECTED_TEAM == "Arsenal"){
            playerImageArray = [UIImage(named: "arsAR"), UIImage(named: "arsAS"), UIImage(named: "arsHB"), UIImage(named: "arsLK"),UIImage(named: "arsMO"), UIImage(named: "arsMA"), UIImage(named: "arsNM"), UIImage(named: "arsOG"), UIImage(named: "arsPM"), UIImage(named: "arsPC"), UIImage(named: "arsTW")]
            
            
        }
        else if(SELECTED_TEAM == "Chelsea"){
             playerImageArray = [UIImage(named: "cheBA"), UIImage(named: "cheCA"), UIImage(named: "cheCF"), UIImage(named: "cheDC"),UIImage(named: "cheEH"), UIImage(named: "cheJM"), UIImage(named: "cheJT"), UIImage(named: "cheKZ"), UIImage(named: "cheO"), UIImage(named: "cheTB"), UIImage(named: "cheW")]
        }
        else if(SELECTED_TEAM == "Leicester City"){
            playerImageArray = [UIImage(named: "lcCF"), UIImage(named: "lcDD"), UIImage(named: "lcDS"), UIImage(named: "lcV"),UIImage(named: "lcKS"), UIImage(named: "lcMA"), UIImage(named: "lcNG"), UIImage(named: "lcRM"), UIImage(named: "lcRH"), UIImage(named: "lcSO"), UIImage(named: "lcWM")]
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        teamselector()
        Firebase(url: "\(PLAYERS_REF)/\(SELECTED_TEAM)").observeEventType(.Value, withBlock: { snapshot in
            var newPlayers = [String]()
            for player in snapshot.children {
                let name = player.value["name"] as! String
                newPlayers.append(name)
            }
            self.playerNames = newPlayers
            self.playerCollection.reloadData()
            print(self.playerNames)
            print(self.playerNames.count)
        })
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.playerNames.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        print(self.playerNames)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier( "cell", forIndexPath: indexPath) as! PlayersViewCell
        
        cell.playerName?.text = self.playerNames[indexPath.row]
        cell.playersImage?.image = self.playerImageArray[indexPath.row]
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(self.playerNames)
        self.performSegueWithIdentifier("showPlayerInfo", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPlayerInfo"{
            let indexPaths = self.playerCollection!.indexPathsForSelectedItems()!
             let indexPath = indexPaths[0] as NSIndexPath
            
            let vc = segue.destinationViewController as! PlayersInfoViewController
            vc.image = self.playerImageArray[indexPath.row]!
            vc.title = self.playerNames[indexPath.row]
        
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