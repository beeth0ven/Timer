# Timer
Closure based timer

Before:
------

 ```swift
class ViewController: UIViewController {
    
    var timer: NSTimer!
    
    var duration = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = NSTimer.scheduledTimerWithTimeInterval(
            1,
            target: self,
            selector: #selector(ViewController.timeAction),
            userInfo: nil, repeats: true)
    }
    
    func timeAction() {
        duration -= 1
        print("Remain: \(duration)")
        if duration <= 0 {
            timer.invalidate()
            print("didFinish")
        }
    }
    
}
 ```
After:
------

 ```swift
 class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSTimer.scheduledTimer(
            timeInterval: 1,
            duration: 10,
            repeatClosure: { remain in print("Remain: \(remain)") },
            didFinish: { print("didFinish") }
        )
    }
}

 ```

License
-------

**Timer** is under MIT license. See the [LICENSE](LICENSE) file for more info.
 


