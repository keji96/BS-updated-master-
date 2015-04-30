//
//  BarbersTableViewController.swift
//  Barbershop
//
//  Created by kevin campbell on 4/6/15.
//  Copyright (c) 2015 kevin campbell. All rights reserved.
//

import UIKit
import Parse

class BarbersTableViewController: UITableViewController {
    
    var barberState = String()
    var barberListDict = [String:Double]()
    var barberNameList = String()
    var barberName = String()
    var barberDistance = Double()
    var barberRange = 5.0
    
    func babershopDataLoad(){
        var currentUser = PFUser.currentUser()
        let userGeoPoint = currentUser!.valueForKey("location") as! PFGeoPoint
        var query = PFQuery(className:"BarbershopInformation")
        
        query.whereKey("Location", nearGeoPoint:userGeoPoint, withinMiles: barberRange)
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
        for object in objects!{
            self.barberName = object.valueForKey("BarbershpName") as! String
            let barberState = object.valueForKey("BarbershopState") as! String
            let pGeoPoint = object.valueForKey("Location") as! PFGeoPoint
           let placeDistance = pGeoPoint.distanceInMilesTo(userGeoPoint)
            self.barberListDict[self.barberName] = placeDistance
            self.tableView.reloadData()
        
        }
      }
    }
}
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let sortedKeys = (barberListDict as NSDictionary).keysSortedByValueUsingSelector("compare:")
        let barberNameSender = sortedKeys[indexPath.row] as! String
        performSegueWithIdentifier("barberdetail", sender: barberNameSender)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is barberdetailViewController {
            var ViewVC = segue.destinationViewController as! barberdetailViewController
            ViewVC.barberDetailName = sender as! String
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        babershopDataLoad()
    
    }

    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return barberListDict.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("barberCell", forIndexPath: indexPath) as! UITableViewCell

        let sortedKeys = (barberListDict as NSDictionary).keysSortedByValueUsingSelector("compare:")
    
        
        barberNameList = sortedKeys[indexPath.row] as! String
        barberDistance = round(barberListDict[barberNameList]!)
        
        
        cell.textLabel!.text = barberNameList
        cell.detailTextLabel!.text = barberDistance.description
    
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.whiteColor()
            cell.textLabel!.textColor = UIColor.blackColor()
            cell.detailTextLabel!.textColor = UIColor.blueColor()
            
        }else{
            cell.backgroundColor = UIColor.grayColor()
            cell.textLabel!.textColor = UIColor.whiteColor()
            cell.detailTextLabel!.textColor = UIColor.blueColor()
        }
        
        return cell
    }
    
    
 

}
