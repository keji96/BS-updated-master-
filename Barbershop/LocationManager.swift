class LocationManager : NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var viewController : ViewController?
    
    init(viewController: ViewController) {
        super.init()
        self.viewController = viewController
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                println("Error:" + error.localizedDescription)
                return
                
            }
            
            if placemarks.count > 0 {

                //println(placemarks[0] as! CLPlacemark)
                
                self.locationManager.stopUpdatingLocation()

                self.viewController?.displayLocationInfo(placemarks[0] as! CLPlacemark)
                
            }else {
                
                println("Error with data")
                
            }
            
        })
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        var alert = UIAlertView(title: "Invalid", message: "Can not get currentlocation \(error.localizedDescription)", delegate: self, cancelButtonTitle: "OK")
        alert.show()
        
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        //println("didChangeAuthorizationStatus")
        
        switch status {
        case .NotDetermined:
            println(".NotDetermined")
            
            
        case .AuthorizedWhenInUse:
            // println(".Authorized")
            self.locationManager.startUpdatingLocation()
            
            
        case .Denied:
            var alert = UIAlertController(title: "Invalid", message: "We need your permission to find your current location", preferredStyle: .Alert)
            
            let cancel = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel) { (action) -> Void in
                let settingsURL = UIApplicationOpenSettingsURLString
                
                UIApplication.sharedApplication().openURL(NSURL(string: settingsURL)!)
            }
            alert.addAction(cancel)
            viewController?.presentViewController(alert, animated: true, completion: nil)
            
            
            println(".Denied")
            
            
        default:
            println("Unhandled authorization status")
            
            
        }
    }
}