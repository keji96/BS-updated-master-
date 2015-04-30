//
//  AppDelegate.swift
//  Barbershop
//
//  Created by kevin campbell on 3/16/15.
//  Copyright (c) 2015 kevin campbell. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        Parse.setApplicationId("JeXEJsZ09HOvsceQ2PUqhYQR7woX5DMm4PuMPtov", clientKey: "VOuisRLlzzh35tpSVYcDVvvK2TeMtlHFmkUvqnXo")
        
//        var query = PFQuery(className:"BarbershopInformation")
//        query.whereKey("BarbershopID", equalTo:4)
//        query.findObjectsInBackgroundWithBlock {
//            (objects: [AnyObject]?, error: NSError?) -> Void in
//            if error == nil {
//                // The find succeeded.
//                println("Successfully retrieved \(objects!.count) cities.")
//                // Do something with the found objects
//                if let objects = objects as? [PFObject] {
//                    for object in objects {
//                        println(object.objectId)
//                    }
//                }
//            } else {
//                // Log details of the failure
//                println("Error: \(error) \(error!.userInfo!)")
//            }
//        }
        
//        var query = PFQuery(className:"BarbershopInformation")
//        query.whereKey("BarbershopState", equalTo: "NY")
//        var objects = query.findObjects()
//        for object in objects{
//        let name = object.valueForKey("BarbershpName") as String
//              println(name)
//        }
//        println("Successfully retrieved \(objects.count) barbers.")
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

   
    }
    
    












