//
//  ViewController.swift
//  TCPSocket
//
//  Created by ChenTsu Lin on 2014/8/27.
//  Copyright (c) 2014年 ChenTsu Lin. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, NSStreamDelegate, UITextFieldDelegate  {
                            
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let textField = UITextField(frame: CGRectMake(50, 50, 20, 10))
//        textField.placeholder = "ip"
//        self.view.addSubview(textField)
        
        let button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(100, 100, 100, 50)
        button.backgroundColor = UIColor.redColor()
        button.setTitle("Test Button", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        var alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: {(alertAction: UIAlertAction!) in
            
            println(alert.textFields[0].text)
            println(alert.textFields[1].text)
            self.connectToSocket(alert.textFields[0].text, port: alert.textFields[1].text)
        
        }))
        
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "IP:"
        })
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Port:"
        })
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func connectToSocket(host: String, port: String) {
    
        var input : NSInputStream?
        var output: NSOutputStream?
        
        var socket: NSStream = NSStream.getStreamstoHost(NSHost.init(host), port, &input, &output)
        
        let str = "test"
        let data = str.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)

        let bytesWritten = output!.write(UnsafePointer(data.bytes), maxLength: data.length)
        
    }
    
    func buttonAction(sender:UIButton!) {
        
        println("Button tapped")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
    
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            //Background Thread
            dispatch_async(dispatch_get_main_queue(), {
                //Run UI Updates
            });
        });
        return true
    }

}

