//
//  LogInViewController.swift
//  Barbershop
//
//  Created by kevin campbell on 4/9/15.
//  Copyright (c) 2015 kevin campbell. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    
    @IBAction func signUpPressed(sender: AnyObject) {
    
        var username = userNameTextField.text
        var password = userPasswordTextField.text
    
        if(count(username) < 4 || count(password) < 6){
            var alert = UIAlertView(title: "Invalid", message: "User name must be greater than 3 and password must be greater than 5", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }else{
            var user = PFUser()
            user.username = userNameTextField.text
            user.password = userPasswordTextField.text
        
        
            user.signUpInBackgroundWithBlock { (success, error) -> Void in
                if error == nil {
                    var alert = UIAlertView(title: "Success", message: "Welcome to the Barbershop", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                
                    self.performSegueWithIdentifier("welcome", sender: nil)
                
                }else{
                Shaker().shakeView(self.userPasswordTextField)
                Shaker().shakeView(self.userNameTextField)
                
            }
        }
    }

  }
    
    @IBAction func logInPressed(sender: AnyObject) {
    
        PFUser.logInWithUsernameInBackground(userNameTextField.text, password: userPasswordTextField.text) { (user, error) -> Void in
            if error == nil{
                self.performSegueWithIdentifier("welcome", sender: nil)
                
                
            }else{
                Shaker().shakeView(self.userPasswordTextField)
                
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // self.view.backgroundColor = UIColor( patternImage: UIImage(named: "Barberposter.jpg")!)
        
        navigationController!.navigationBar.barTintColor = UIColor.redColor()
    navigationController!.navigationBar.backgroundColor  = UIColor( patternImage: UIImage(named: "Barberposter.jpg")!)
        
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
