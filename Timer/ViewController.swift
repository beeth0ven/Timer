//
//  ViewController.swift
//  Timer
//
//  Created by luojie on 16/3/29.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NSTimer.scheduledTimer(
            timeInterval: 1,
            duration: 10,
            repeatClosure: { print("Reamin: \($0)") },
            didFinish: { print("didFinish") }
        )
    }

}





