//
//  shaker.swift
//  testshake2
//
//  Created by kevin campbell on 3/4/15.
//  Copyright (c) 2015 kevin campbell. All rights reserved.
//

import Foundation
import UIKit
class Shaker {
    func shakeView(inputTest: UIView){
        var shake:CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 10
        shake.autoreverses = true
        var from_point:CGPoint = CGPointMake(inputTest.center.x - 5, inputTest.center.y)
        var from_value:NSValue = NSValue(CGPoint: from_point)
        
        var to_point:CGPoint = CGPointMake(inputTest.center.x + 5, inputTest.center.y)
        var to_value:NSValue = NSValue(CGPoint: to_point)
        
        shake.fromValue = from_value
        shake.toValue = to_value
        inputTest.layer.addAnimation(shake, forKey: "position")
    }
}
