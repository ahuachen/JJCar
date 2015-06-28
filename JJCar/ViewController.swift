//
//  ViewController.swift
//  JJCar
//
//  Created by ahua on 15/6/28.
//  Copyright (c) 2015年 ahua. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var msgTxt: UITextView!

    var carState = false {
        willSet(state) {
            println("About set carStat to \(state)")
        }
        didSet {
//            if carState != oldValue {
                if carState {
                    notifyLabel.text = "Car Online!!!!"
                    msgTxt.text = nil
                } else {
                    notifyLabel.text = "Car Offline!!!"
                }
//            }
            println("Tun state from \(carState) to \(oldValue)")
        }
    }
    var url = "http://192.168.31.201:5000/carServer/action"
    
    @IBOutlet weak var notifyLabel: UILabel!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        notifyCar(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func notifyCar(action:Int) {
        println("Action :\(action)")
        var req = NSMutableURLRequest(URL: NSURL(string: url)!)
        req.HTTPMethod = "POST"
        req.HTTPBody = NSString(string: "action=\(action)&stamp=\(timezone)").dataUsingEncoding(NSUTF8StringEncoding)
        NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue.mainQueue()) { (response, data, error)-> Void in
            if error != nil {
                self.carState = false
                self.msgTxt.text = error.description
                println("Error:\(error)")
            } else {
                if let d = data{
                    var postMsg = NSString(data: d, encoding: NSUTF8StringEncoding)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let resMsg = (postMsg! as NSString)
                        if resMsg.hasPrefix("OK"){
                            self.carState = true
                        } else {
                            self.carState = false
                        }
                    })
                }
            }
        }
    }
    
    
    
    @IBAction func connect(sender: AnyObject) {
        
        println("Connect begin!!!")
//        notifyLabel.text = "Hello!!!"
        notifyCar(0)
//        
//        if carState {
//            notifyLabel.text = "Car Online!!!"
//        } else {
//            notifyLabel.text = "Car Offline!!!"
//        }
        
    }
    
    
    @IBAction func leftDown(sender: AnyObject) {
        println("leftDown")
        if carState {
           notifyCar(1)
        }
    }
    
    @IBAction func leftUp(sender: AnyObject) {
        println("leftUp")
        if carState {
            notifyCar(0)
        }
    }
    @IBAction func rightDown(sender: AnyObject) {
        println("rightDown")
        if carState {
            notifyCar(2)
        }
    }
    
    @IBAction func rightUp(sender: AnyObject) {
        println("rightUp")
        if carState {
            notifyCar(0)
        }
    }
    
    @IBAction func upDown(sender: AnyObject) {
        println("upDown")
        if carState {
            notifyCar(4)
        }
    }
    
    @IBAction func upUp(sender: AnyObject) {
        println("upUp")
        if carState {
            notifyCar(0)
        }
    }
    
    @IBAction func backDown(sender: AnyObject) {
        println("backDown")
        if carState {
            notifyCar(8)
        }
    }
    
    @IBAction func backUp(sender: AnyObject) {
        println("backUp")
        if carState {
            notifyCar(0)
        }
    }
}

