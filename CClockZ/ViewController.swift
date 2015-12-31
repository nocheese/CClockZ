//
//  ViewController.swift
//  CClockZ
//
//  Created by Chazo on 15/12/31.
//  Copyright © 2015年 chazo. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    var timeButton1:UIButton!
    var timeButton2:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timeButton1 = UIButton.init(frame: CGRectMake(0, 50, 300, 60))
        timeButton1.backgroundColor = UIColor.blueColor()
        timeButton1.tag = 15;
        timeButton1.setTitle("15min", forState: UIControlState.Normal)
        timeButton1.addTarget(self, action: Selector("didTapButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(timeButton1)
        
        timeButton2 = UIButton.init(frame: CGRectMake(0, 150, 300, 60))
        timeButton2.backgroundColor = UIColor.blueColor()
        timeButton2.tag = 25;
        timeButton2.setTitle("25min", forState: UIControlState.Normal)
        timeButton2.addTarget(self, action: Selector("didTapButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(timeButton2)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("didReceiveLocalNotification"), name: "didReceiveLocalNotification", object: nil)
    }
    
    func didReceiveLocalNotification() {
        
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        AudioServicesPlaySystemSound(1317)
        
        timeButton1.enabled = true
        timeButton2.enabled = true
        
        timeButton1.setTitle("15min", forState: UIControlState.Normal)
        timeButton2.setTitle("25min", forState: UIControlState.Normal)
        
        let alert:UIAlertController = UIAlertController.init(title: "CClockZ", message: "time is up", preferredStyle: UIAlertControllerStyle.Alert)
        let cancel:UIAlertAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        alert .addAction(cancel)
        self .presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func didTapButton(button:UIButton) {
        timeButton1.enabled = false
        timeButton2.enabled = false
        NSLog("1")
        button.setTitle("do your work", forState: UIControlState.Normal)
        
        let min = Double(button.tag)
        
        let localNotification:UILocalNotification = UILocalNotification.init()
        localNotification.timeZone = NSTimeZone.localTimeZone()
        localNotification.alertTitle = "CClockZ";
        localNotification.alertBody = "time is up"
        localNotification.fireDate = NSDate(timeIntervalSinceNow:min*60)
        localNotification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

