//
//  ChatViewController.swift
//  Chat
//
//  Created by Shakeeb Majid on 2/5/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{

    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var messageText: UITextField!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var messages: [String] = []
    var users: [String] = []
    //var numMessages: [int]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        
        
        
        var message = PFObject(className:"Message")
        message["text"] = messageText.text
        message["user"] = PFUser.currentUser()
                message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                //print(message["user"].username)
                //print(message["text"])
            } else {
                // There was a problem, check error.description
            }
        }
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimer", userInfo: nil, repeats: true)

    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell", forIndexPath: indexPath) as! messageCell
        
        cell.messageLabel.text = messages[indexPath.row]
        //if users[indexPath.row] != "" {
        cell.userLabel.text = users[indexPath.row]
       // } else {
           // cell.userLabel.text = "Anonymous"
       // }
       
        //print("heeeeeeeey \(messages[indexPath.row])")
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if messages.count != 0 {
           // print(messages.count)
            return messages.count
            
        } else {
            return 0
        }
    }

    
    func onTimer() {
        //var temp: [String]
        //temp = []
        
        var query = PFQuery(className:"Message")
        //query.whereKey("text", equalTo: "hey" )
        query.includeKey("user")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            self.messages = []
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) messages.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print("text: \(object["text"])")
                        self.messages.append(object["text"] as! String)
                        if object["user"] != nil {
                            print("user: \(object["user"].username)")
                            self.users.append(object["user"].username!!)
                        } else {
                            self.users.append("no name bitch")
                            print("user: no name bitch")
                        }
                        
                       
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }

        tableView.reloadData()
        // Add code to be run periodically
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
