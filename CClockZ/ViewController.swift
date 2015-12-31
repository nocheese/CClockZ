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
    var timeInput:UITextField!
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let screenWidth:CGFloat = UIScreen.mainScreen().bounds.size.width;
        
        self.view.backgroundColor = UIColor(colorLiteralRed: 0.184, green: 0.710, blue: 1.000, alpha: 1.000)
        
        timeInput = UITextField.init(frame: CGRectMake(0, 60, screenWidth, 60))
        timeInput.placeholder = "input time (min)"
        timeInput.textAlignment = NSTextAlignment.Center
        timeInput.tintColor = UIColor.whiteColor()
        timeInput.textColor = UIColor.whiteColor()
        timeInput.backgroundColor = UIColor(colorLiteralRed: 0.000, green: 0.612, blue: 1.000, alpha: 1.000)
        timeInput.keyboardType = UIKeyboardType.NumberPad
        timeInput .addTarget(self, action: Selector("textDidChanged:"), forControlEvents: UIControlEvents.EditingChanged)
        self.view.addSubview(timeInput)
//        UIColor *color = [UIColor colorWithRed:0.000 green:0.612 blue:1.000 alpha:1.000]
        
        timeButton1 = UIButton.init(frame: CGRectMake(0, CGRectGetMaxY(timeInput.frame), screenWidth, 60))
        timeButton1.backgroundColor = UIColor(colorLiteralRed: 0.000, green: 0.475, blue: 0.910, alpha: 1.000)
        timeButton1.tag = 15
        timeButton1.setTitle("15min", forState: UIControlState.Normal)
        timeButton1.addTarget(self, action: Selector("didTapButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(timeButton1)
        
//        timeButton2 = UIButton.init(frame: CGRectMake(0, 150, 300, 60))
//        timeButton2.backgroundColor = UIColor.blueColor()
//        timeButton2.tag = 25;
//        timeButton2.setTitle("25min", forState: UIControlState.Normal)
//        timeButton2.addTarget(self, action: Selector("didTapButton:"), forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(timeButton2)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("didReceiveLocalNotification"), name: "didReceiveLocalNotification", object: nil)
    }
    
    func textDidChanged(textfield:UITextField) {
        let string:String = textfield.text!
        if string.isEmpty {
            timeButton1.tag = 15;
            timeButton1.setTitle("15min", forState: UIControlState.Normal)
            return;
        }
        let integerValue = NSInteger(string)
        timeButton1.tag = integerValue!
        timeButton1.setTitle("\(string)min", forState: UIControlState.Normal)
    }
    
    func didReceiveLocalNotification() {
        
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//        AudioServicesPlaySystemSound(1317)
        
        timeButton1.enabled = true
//        timeButton2.enabled = true
        
        timeButton1.setTitle("15min", forState: UIControlState.Normal)
        timeButton1.tag = 15
//        timeButton2.setTitle("25min", forState: UIControlState.Normal)
        
        let alert:UIAlertController = UIAlertController.init(title: "CClockZ", message: "time is up", preferredStyle: UIAlertControllerStyle.Alert)
        let cancel:UIAlertAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        alert .addAction(cancel)
        self .presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func didTapButton(button:UIButton) {
        timeButton1.enabled = false
//        timeButton2.enabled = false
        NSLog("1")
        button.setTitle("do your work", forState: UIControlState.Normal)
        
        let min = Double(button.tag)
        
        let localNotification:UILocalNotification = UILocalNotification.init()
        localNotification.timeZone = NSTimeZone.localTimeZone()
        localNotification.alertTitle = "CClockZ";
        localNotification.alertBody = "time is up"
        localNotification.fireDate = NSDate(timeIntervalSinceNow:min*60)
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.repeatInterval = NSCalendarUnit.Minute
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

