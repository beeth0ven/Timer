//
//  BNQueue.swift
//
//  Created by luojie on 15/12/15.
//  Copyright © 2015年 LuoJie. All rights reserved.
//

import Foundation

 /**
 Provide a GCD convenience API
    - Main:                 MainQueue
    - UserInteractive:      Queue With Hight Priority
    - UserInitiated:        Queue With Medium Priority
    - Utility:              Queue With Low Priority
    - Background:           Queue With Very Low Priority
 
 Downloading something then could be written like this:
 
 ```swift
BNQueue.UserInitiated.execute {
 
    let url = NSURL(string: "http://image.jpg")!
    let data = NSData(contentsOfURL: url)!
    let image = UIImage(data: data)
 
    BNQueue.Main.execute {
        imageView.image = image
    }
 }
  ```
 */


public enum BNQueue: ExcutableQueue {
    case Main
    case UserInteractive
    case UserInitiated
    case Utility
    case Background
    
    public var queue: dispatch_queue_t {
        switch self {
        case .Main:
            return dispatch_get_main_queue()
        case .UserInteractive:
            return dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)
        case .UserInitiated:
            return dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
        case .Utility:
            return dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)
        case .Background:
            return dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)
        }
    }
    
    public static func scheduledTimer(timeInterval timeInterval: NSTimeInterval = 1, duration: NSTimeInterval, repeatClosure: (remain: NSTimeInterval) -> Void, didFinish: (() -> Void)? = nil) {
        var duration = duration
        BNQueue.Main.executeAfter(seconds: timeInterval) {
            duration -= timeInterval
            repeatClosure(remain: duration)
            if duration <= 0 {
                didFinish?()
            } else {
                scheduledTimer(timeInterval: timeInterval, duration: duration, repeatClosure: repeatClosure, didFinish: didFinish)
            }
        }
    }
}



public protocol ExcutableQueue {
    var queue: dispatch_queue_t { get }
}

public extension ExcutableQueue {
    public func execute(closure: () -> Void) {
        dispatch_async(queue, closure)
    }
    
    public func executeAfter(seconds seconds: NSTimeInterval, closure: () -> Void) {
        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
        dispatch_after(delay, queue, closure)
    }
}