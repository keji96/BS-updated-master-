//
//  reviewViewController.swift
//  Barbershop
//
//  Created by kevin campbell on 4/17/15.
//  Copyright (c) 2015 kevin campbell. All rights reserved.
//

import UIKit

class reviewViewController: UIViewController {

    
    var barberratingsName = String()
    @IBOutlet weak var reviewTextField: UITextView!
    @IBOutlet weak var ratingsSlider: UISlider!
    
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    @IBAction func closeModalView(sender: AnyObject) {
    
    self.dismissViewControllerAnimated(false, completion: nil)
    
    }
    
    
    
    @IBAction func saveReviewPressed(sender: AnyObject) {
    
          var reviewsRatings = PFObject(className: "ReviewsRatings")
            reviewsRatings["Ratings"] = ratingsSlider.value
            reviewsRatings["Reviews"] = reviewTextField.text
            reviewsRatings["BarbershopName"] = barberratingsName
            reviewsRatings["Customer"] = PFUser.currentUser()
        
            reviewsRatings.saveInBackgroundWithBlock { (success, error) -> Void in
                var alert = UIAlertView(title: "Success", message: "Rating and Review saved", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ratingLabel.text = "Review and Rate \(barberratingsName)"
        reviewTextField.layer.borderColor = UIColor.blackColor().CGColor
        reviewTextField.layer.borderWidth = 0.5
        
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
