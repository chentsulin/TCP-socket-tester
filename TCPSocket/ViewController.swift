//
//  ViewController.swift
//  TCPSocket
//
//  Created by ChenTsu Lin on 2014/8/27.
//  Copyright (c) 2014年 ChenTsu Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSStreamDelegate, UITextFieldDelegate  {
                            
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(100, 100, 100, 50)
        button.backgroundColor = UIColor.redColor()
        button.setTitle("Test Button", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button)
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

