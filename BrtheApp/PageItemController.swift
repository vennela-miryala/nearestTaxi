//
//  PageItemController.swift
//  BrtheApp
//
//  Created by apple on 12/19/14.
//  Copyright (c) 2014 Brthe. All rights reserved.
//

import UIKit

class PageItemController: UIViewController, FBLoginViewDelegate {

    @IBOutlet var fbLoginView : FBLoginView!
    // MARK: - Variables
    var itemIndex: Int = 0
    var imageName: String = "" {
        
        didSet {
            
            if let imageView = contentImageView {
                imageView.image = UIImage(named: imageName)
            }
            
        }
    }

    @IBOutlet weak var contentImageView: UIImageView!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Walkthrough
//        contentImageView!.image = UIImage(named: imageName)
//        
//        // FB Work
//        self.fbLoginView.delegate = self
//        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]
        
        
        // Parse
        PFFacebookUtils.logInWithPermissions(permissions, {
            (user: PFUser!, error: NSError!) -> Void in
            if user == nil {
                NSLog("Uh oh. The user cancelled the Facebook login.")
            } else if user.isNew {
                NSLog("User signed up and logged in through Facebook!")
            } else {
                NSLog("User logged in through Facebook!")
            }
        })
    
    }
    
    // Simple POST function
    func post(params: Dictionary<String, String>, url: String) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as NSDictionary
            
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                let parseJSON = json
                //                if let parseJSON = json {
                // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                var success = parseJSON["success"] as? Int
                println("Succes: \(success)")
                //                }
                //                else {
                //                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                //                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                //                    println("Error could not parse JSON: \(jsonStr)")
                //                }
            }
        })
        task.resume()
    }
    
    
//    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
//        println("User Logged In")
//        println("This is where you perform a segue.")
//        self.performSegueWithIdentifier("goToHome", sender: self)
//    }
//
//    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser){
//        println("User: \(user)")
//        println("User ID: \(user.objectID)")
//        println("User Name: \(user.name)")
//        var userEmail = user.objectForKey("email") as String
//        println("User Email: \(userEmail)")
//        var userGender = user.objectForKey("gender") as String
//
//        // Call post method here
//        self.post(["_id":user.objectID, "name":user.name, "gender":userGender, "link":user.link, "email":userEmail], url: "http://54.68.32.118:8080/users")
//        println("Posted to server")
//    }
//
//    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
//        println("User Logged Out")
//    }
//
//    func loginView(loginView : FBLoginView!, handleError:NSError) {
//        println("Error: \(handleError.localizedDescription)")
//    }

    //  Get List Of Friends
    
    //    var friendsRequest : FBRequest = FBRequest.requestForMyFriends()
    //    friendsRequest.startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
    //    var resultdict = result as NSDictionary
    //    println("Result Dict: \(resultdict)")
    //    var data : NSArray = resultdict.objectForKey("data") as NSArray
    //
    //    for i in 0..&lt;data.count {
    //    let valueDict : NSDictionary = data[i] as NSDictionary
    //    let id = valueDict.objectForKey("id") as String
    //    println("the id value is \(id)")
    //    }
    //
    //    var friends = resultdict.objectForKey("data") as NSArray
    //    println("Found \(friends.count) friends")
    //    }

}
