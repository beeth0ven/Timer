//
//  NSTimer+Closure.swift
//  NSTimer+Closure
//
//  Created by luojie on 16/3/29.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation

extension NSTimer {
    /**
     Closure based timer
     - parameter timeInterval: timeInterval default value 1 seconds
     - parameter duration: total time
     - parameter repeatClosure: called when timeInterval arrived
     - parameter didFinish: called when count down is finished
     */
    static func scheduledTimer(timeInterval timeInterval: NSTimeInterval = 1, duration: NSTimeInterval, repeatClosure: (remain: NSTimeInterval) -> Void, didFinish: (() -> Void)? = nil) -> NSTimer {
        let controller = Controller(timeInterval: timeInterval, duration: duration, repeatClosure: repeatClosure, didFinish: didFinish)
        let timer = scheduledTimerWithTimeInterval(timeInterval, target: controller, selector: #selector(Controller.action), userInfo: nil, repeats: true)
        timer.controller = controller
        timer.controller.timer = timer
        return timer
    }
    
    private var controller: Controller! {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.Controller) as? Controller }
        set { objc_setAssociatedObject(self, &AssociatedKeys.Controller, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    private class Controller {
        
        weak var timer: NSTimer!
        private let timeInterval: NSTimeInterval
        private var duration: NSTimeInterval
        private let repeatClosure: (remain: NSTimeInterval) -> Void
        private let didFinish: (() -> Void)?
        
        init(timeInterval: NSTimeInterval, duration: NSTimeInterval, repeatClosure: (remain: NSTimeInterval) -> Void, didFinish: (() -> Void)?) {
            self.timeInterval = timeInterval
            self.duration = duration
            self.repeatClosure = repeatClosure
            self.didFinish = didFinish
        }
        
        @objc func action() {
            duration -= timeInterval
            repeatClosure(remain: duration)
            if duration <= 0 {
                didFinish?()
                timer.invalidate()
            }
        }
        
    }
    
    private struct AssociatedKeys {
        static var Controller = "Controller"
    }
}

