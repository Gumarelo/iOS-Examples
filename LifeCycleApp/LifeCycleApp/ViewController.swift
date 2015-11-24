//
//  ViewController.swift
//  LifeCycleApp
//
//  Created by Jorge Casariego on 30/10/15.
//  Copyright © 2015 Jorge Casariego. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         NSLog("viewDidAppear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        NSLog("viewDidAppear")
    }
    
    override func viewWillAppear(animated: Bool) {
        NSLog("viewWillAppear")
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "updateGUI:",
            name: UIApplicationWillEnterForegroundNotification,
            object: nil)
    }
    
    @objc func updateGUI(){
         NSLog("volvimos desde el home")
    }
    

    
    


}

