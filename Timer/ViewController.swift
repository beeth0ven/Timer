//
//  ViewController.swift
//  Timer
//
//  Created by luojie on 16/3/29.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit


//class ViewController: UIViewController {
//    
//    var timer: NSTimer!
//    
//    var duration = 10.0
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        timer = NSTimer.scheduledTimerWithTimeInterval(
//            1,
//            target: self,
//            selector: #selector(ViewController.timeAction),
//            userInfo: nil, repeats: true)
//    }
//    
//    func timeAction() {
//        duration -= 1
//        print("Reamin: \(duration)")
//        if duration <= 0 {
//            timer.invalidate()
//            print("didFinish")
//        }
//    }
//    
//}



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NSTimer.scheduledTimer(
            timeInterval: 1,
            duration: 10,
            repeatClosure: { reamin in print("Reamin: \(reamin)") },
            didFinish: { print("didFinish") }
        )
    }

}





