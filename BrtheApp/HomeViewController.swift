//
//  HomeViewController.swift
//  BrtheApp
//
//  Created by apple on 12/17/14.
//  Copyright (c) 2014 Brthe. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var myLocation: UITextField!
    @IBOutlet weak var myDestination: UITextField!
    
    // Simple POST function
    func get(url: String) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        
        var err: NSError?
//        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.layer.shadowColor = UIColor.blackColor().CGColor
        headerView.layer.shadowOffset = CGSize(width: 0,height: 1.5)
        headerView.layer.shadowOpacity = 0.25
        headerView.layer.shadowRadius = 1.0
        headerView.layer.cornerRadius = 2.5
        
//        get("https://maps.googleapis.com/maps/api/place/autocomplete/json?input=Vict&types=geocode&language=en&key=AIzaSyAHqpH2hEFMcetoyguhfSWYd2RDPTmSj8o")
        
        let url = NSURL(string: "http://www.stackoverflow.com")
        let request = NSURLRequest(URL: url!)
//        Then, you can load the request asynchronously with:
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            println(response)
//            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        // Do any additional setup after loading the view.
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
