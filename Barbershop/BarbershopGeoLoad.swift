//
//  barbershopGeoLoad.swift
//  Barbershop
//
//  Created by kevin campbell on 4/8/15.
//  Copyright (c) 2015 kevin campbell. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import AddressBook
import MapKit


class BarbershopGeoLoad {
    var barberGeoName = String()
    var barberGeoState = String()
    var barberGeoCity = String()
    var barberGeoAddress = String()
    var barberGeoZipCode = String()
    var barberGeoCountry = String()
   
    
    func babershopGeoDataLoad(){
       var query = PFQuery(className:"BarbershopInformation")
       query.whereKey("BarbershopID", greaterThanOrEqualTo: 0)
       query.whereKeyDoesNotExist("Location")
        
        query.findObjectsInBackgroundWithBlock {
        (objects: [AnyObject]?, error: NSError?) -> Void in
        if error == nil {
        
        for object in objects!{
            self.barberGeoName = object.valueForKey("BarbershpName") as! String
            self.barberGeoAddress = object.valueForKey("BarbershopStreetAddress")as! String
            self.barberGeoCity = object.valueForKey("BarbershopCity") as! String
            self.barberGeoState = object.valueForKey("BarbershopState") as! String
            self.barberGeoZipCode = object.valueForKey("BarbershopRealZip")as! String
            self.barberGeoCountry = object.valueForKey("BarbershopCountry") as! String
            
            //println(self.barberGeoName)
            let geoCoder = CLGeocoder()
            let addressString = "\(self.barberGeoAddress) \(self.barberGeoCity) \(self.barberGeoState) \(self.barberGeoZipCode)"
            
            geoCoder.geocodeAddressString(addressString, completionHandler: { (placemarks: [AnyObject]!, error: NSError!) -> Void in
                if error != nil {
                    println("Geocode failed with error: \(error.localizedDescription)")
                }else if placemarks.count > 0 {
                    let placemark = placemarks[0] as! CLPlacemark
                    let location = placemark.location
                    let geoLocation = location.coordinate
                    let geoLatitude = geoLocation.latitude
                    let geoLongitude = geoLocation.longitude
                    let barberPoint = PFGeoPoint(latitude:geoLatitude, longitude:geoLongitude)
                    
                   object.setValue(barberPoint, forKey: "Location")
                    object.saveInBackgroundWithBlock {
                        (success: Bool, error: NSError?) -> Void in
                        if (success) {
                            // The object has been saved.
                        } else {
                            // There was a problem, check error.description
                        }
                    }
                    
                    
                }
            })
       
        
         }
        
     }

   }
 }

}