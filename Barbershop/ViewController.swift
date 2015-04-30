//
//  ViewController.swift
//  Barbershop
//
//  Created by kevin campbell on 3/16/15.
//  Copyright (c) 2015 kevin campbell. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import AddressBook


class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var addressTextField: UITextField!

    @IBOutlet weak var cityTextField: UITextField!
    
    
    @IBOutlet weak var stateTextField: UITextField!
    
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    @IBOutlet weak var countryTextBox: UITextField!
    
    var distancePickerArray = ["5","10","20","50","100","3000"]
    var distancePicked = 5.0
    var locationManager : LocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager = LocationManager(viewController: self)
        BarbershopGeoLoad().babershopGeoDataLoad()
    }
    
    //displayLocationInfo
    func displayLocationInfo(currentCity : CLPlacemark){
        cityTextField.text = currentCity.locality
        stateTextField.text = currentCity.administrativeArea
        zipCodeTextField.text = currentCity.postalCode
        countryTextBox.text = currentCity.country
        addressTextField.text = currentCity.name
        let curLoc = currentCity.location
        
       
        let curCor = curLoc.coordinate
        let curLat = curCor.latitude
        let curLong = curCor.longitude
    
        let curGeoPoint = PFGeoPoint(latitude:curLat, longitude:curLong)
        var currentUser = PFUser.currentUser()
        currentUser!.setValue(curGeoPoint, forKey: "location")
        currentUser?.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
        //println(point)
    }
   
    //MARK Function for picker view. To pick search area for barbershops
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return distancePickerArray.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return distancePickerArray[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let pickdistance = distancePickerArray[row]
            distancePicked = (pickdistance as NSString).doubleValue
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is BarbersTableViewController{
            var ViewVC = segue.destinationViewController as! BarbersTableViewController
            ViewVC.barberRange = distancePicked
        }
    }
}

