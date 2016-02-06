//
//  ViewController.swift
//  Chat
//
//  Created by Shakeeb Majid on 2/4/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    
    
    @IBOutlet weak var passwordText: UITextField!
    
    
    @IBAction func signIn(sender: AnyObject) {
        print("Hey you just signed in")
        
        var user = PFUser()
        user.username = emailText.text
        user.password = passwordText.text
        //user.email = emailText.text
        // other fields can be set just like with PFObject
        //user["phone"] = "415-392-0202"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
            }
        }
        
        print("\(user.password)")
        print("\(user.username)")
        
    }
    
    @IBAction func logIn(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(emailText.text!, password:passwordText.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("hey you just logged in")
                
                let next = self.storyboard?.instantiateViewControllerWithIdentifier("ChatViewController") as! ChatViewController
                self.presentViewController(next, animated: true, completion: nil)
                
                
                
                //let vc = ChatViewController()
                //self.presentViewController(vc, animated: true, completion: nil)

                // Do stuff after successful login.
            } else {
            
                
                               // The login failed. Check error to see why.
            }
        }

        
        
        
        
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

