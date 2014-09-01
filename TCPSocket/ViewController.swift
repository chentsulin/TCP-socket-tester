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
        
        println(1)
        var alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: {(alertAction: UIAlertAction!) in
            
            let ipTextField   = alert.textFields[0] as UITextField
            let portTextField = alert.textFields[1] as UITextField
            
            println(ipTextField.text)
            println(portTextField.text)
            self.connectToSocket(ipTextField.text, port: portTextField.text.toInt()!)
        
        }))
        
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "IP:"
        })
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Port:"
        })
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func connectToSocket(host: String, port: Int) {
    
        var input : NSInputStream?
        var output: NSOutputStream?
        
        println(host)
        println(port)
        
        NSStream.getStreamsToHostWithName(host, port: port, inputStream: &input, outputStream: &output)
        
        let str = "test"
        let data = str.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        
        println(data)
        println(data.length)
        
        output?.open()


        let bytesWritten = output!.write(UnsafePointer(data.bytes), maxLength: data.length)
        
        println(bytesWritten)
        
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

