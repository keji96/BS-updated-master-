//
//  barberdetailViewController.swift
//  Barbershop
//
//  Created by kevin campbell on 4/8/15.
//  Copyright (c) 2015 kevin campbell. All rights reserved.
//

import UIKit
import CoreLocation
import AddressBook
import MapKit

class barberdetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

   var barberDetailName = String()
   var barberDetailState = String()
   var barberDetailCity = String()
   var barberDetailAddress = String()
   var barberDetailZipCode = String()
   var barberDetailCountry = String()
   var barberReviewDetail = String()
   var barberReviewDate = NSDate()
   var barberReviewRate = Float()
   var barberReviewRateArray = [Float]()
   var ratingsReviewDic = [NSDate : String]()
   
   
   
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    @IBOutlet weak var barberDetailNameField: UITextField!
    @IBOutlet weak var barberDetailAddressField: UITextField!
    @IBOutlet weak var barberDetailCityField: UITextField!
    @IBOutlet weak var barberDetailStateField: UITextField!
    @IBOutlet weak var barberDetailZipCodeField: UITextField!
    
    
    
    var coords: CLLocationCoordinate2D?
    
    @IBAction func goThereMap(sender: AnyObject) {
        let geoCoder = CLGeocoder()
        let addressString = "\(barberDetailAddress) \(barberDetailCity) \(barberDetailState) \(barberDetailZipCode)"
        
        geoCoder.geocodeAddressString(addressString, completionHandler: { (placemarks: [AnyObject]!, error: NSError!) -> Void in
            if error != nil {
                println("Geocode failed with error: \(error.localizedDescription)")
            }else if placemarks.count > 0 {
                let placemark = placemarks[0] as! CLPlacemark
                let location = placemark.location
                self.coords = location.coordinate
                
                self.showMap()
            }
        })

    
    
    
    }
    
    func showMap() {
        let addressDict = [
            kABPersonAddressStreetKey as NSString: barberDetailAddress,
            kABPersonAddressCityKey: barberDetailCity,
            kABPersonAddressStateKey: barberDetailState,
            kABPersonAddressZIPKey: barberDetailZipCode
        ]
        
        let place = MKPlacemark(coordinate: coords!, addressDictionary: addressDict)
        let mapitem = MKMapItem(placemark: place)
        let options = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
        mapitem.openInMapsWithLaunchOptions(options)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        babershopDetailDataLoad()
        barberReview()
       //self.tableView.reloadData()
    
    }

    override func viewDidAppear(animated: Bool) {
        barberReview()
    
    
    }
    
    
    func babershopDetailDataLoad(){
        var query = PFQuery(className:"BarbershopInformation")
        query.whereKey("BarbershpName", equalTo: barberDetailName)
    
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
        
                for object in objects!{
                    self.barberDetailAddress = object.valueForKey("BarbershopStreetAddress") as! String
                    self.barberDetailCity = object.valueForKey("BarbershopCity") as! String
                    self.barberDetailState = object.valueForKey("BarbershopState") as! String
                    self.barberDetailZipCode = object.valueForKey("BarbershopRealZip") as! String
                    self.barberDetailCountry = object.valueForKey("BarbershopCountry") as! String
                
                    self.barberDetailNameField.text = self.barberDetailName
                    self.barberDetailAddressField.text = self.barberDetailAddress
                    self.barberDetailCityField.text = self.barberDetailCity
                    self.barberDetailStateField.text = self.barberDetailState
                    self.barberDetailZipCodeField.text = self.barberDetailZipCode
                
                 
                }
            }else {
                // Log details of the failure
                println("Error: \(error) \(error!.userInfo!)")
            }
        }
  }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is reviewViewController {
            var ViewVC = segue.destinationViewController as! reviewViewController
            ViewVC.barberratingsName = barberDetailName as String
        }
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratingsReviewDic.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reviewCell", forIndexPath: indexPath) as! UITableViewCell
        
      //let sortedKeys = Array(ratingsReviewDic.keys).sorted(<)
        
        let barberDate = ratingsReviewDic.keys.array[indexPath.row]
        cell.textLabel!.text = ratingsReviewDic[barberDate]
        cell.detailTextLabel!.text = barberDate.description
        
    return cell
    }
    
    
    func barberReview() {
       var query = PFQuery(className:"ReviewsRatings")
       query.whereKey("BarbershopName", equalTo: barberDetailName)
       
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                
                for object in objects!{
                  self.barberReviewDetail = object.valueForKey("Reviews") as! String
                  self.barberReviewDate = object.valueForKey("createdAt") as! NSDate
                  self.ratingsReviewDic[self.barberReviewDate] = self.barberReviewDetail
                
                  self.barberReviewRate = object.valueForKey("Ratings") as! Float
                  self.barberReviewRateArray.append(self.barberReviewRate)
                  self.tableView.reloadData()
                  
            
                }
             }else {
                // Log details of the failure
                println("Error: \(error) \(error!.userInfo!)")
              }
         }
        let ratingsAvg = barberReviewRateArray.reduce(0) { $0 + $1 } / Float(barberReviewRateArray.count)
        let roundRatingsAvg = round(ratingsAvg)
        self.title = "\(barberDetailName) is rated \(roundRatingsAvg) out of 5.0"
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

