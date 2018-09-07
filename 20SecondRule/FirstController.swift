//
//  FirstController.swift
//  20SecondRule
//
//  Created by Neil Sood on 9/6/18.
//  Copyright © 2018 Neil Sood. All rights reserved.
//

import UIKit
import SpriteKit
import CoreMotion

//class Dude{
//    var name: String = "Dude"
//    name = "dingleberry"
//}

class FirstController: UIViewController {

    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
//    variables timer
    var timer = Timer()
    var seconds = 20
    
    
    
    @IBOutlet weak var imageMotion: UIImageView!
    let motionManager = CMMotionManager()
    let opQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @objc func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(FirstController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if seconds > 0 {
            seconds -= 1     //This will decrement(count down)the seconds.
        }
        countdownLabel.text = "\(seconds)" //This will update the label.
        if seconds == 0 {
            startButton.layer.cornerRadius = 5
            startButton.isHidden = false
            countdownLabel.isHidden = true
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        startButton.isHidden = true
        seconds = 20
        countdownLabel.text = "\(seconds)"
        countdownLabel.isHidden = false
        timer.invalidate()
        runTimer()
//        if motionManager.isDeviceMotionAvailable {
//            print("We can detect device motion")
////            startReadingMotionData()
////            isPlaying = true
//        }
//        else {
//            print("We cannot detect device motion")
//        }
    }
    
//    func startReadingMotionData() {
//        // set read speed
//        motionManager.deviceMotionUpdateInterval = 0.1
//        // image position object
//        var frm: CGRect = self.imageMotion.frame
//        // start reading
//        motionManager.startDeviceMotionUpdates(to: opQueue) {
//            (data: CMDeviceMotion?, error: Error?) in
//
//            if let mydata = data {
////                let x = self.imageMotion.frame.origin.x
////                let y = self.imageMotion.frame.origin.y
//
//                if mydata.gravity.y < 0 {
////                    y -= 10
////                    print("y: \(y)")
//                    frm.origin.x = frm.origin.x - 1
//                    self.imageMotion.frame = frm
//                }
//                if mydata.gravity.y > 0 {
////                    y += 10
////                    print("y: \(y)")
//                    frm.origin.x = frm.origin.x + 1
//                    self.imageMotion.frame = frm
//                }
//                if mydata.gravity.x < 0 {
////                    x -= 10
////                    print("x: \(x)")
//                    frm.origin.y = frm.origin.y - 1
//                    self.imageMotion.frame = frm
//                }
//                if mydata.gravity.x > 0 {
////                    x += 10
////                    print("x: \(x)")
//                    frm.origin.y = frm.origin.y + 1
//                    self.imageMotion.frame = frm
//                }
//
//                frm.size.width = frm.size.width
//                frm.size.height = frm.size.height
//
////                var frm: CGRect = imageView.frame
////                frm.origin.x = frm.origin.x - 50
////                frm.origin.y = frm.origin.y - 50
////                imageMotion.frame = frm
//
//            }
//        }
//    }
//
//    func degrees(_ radians: Double) -> Double {
//        return 180/Double.pi * radians
//    }
    
    @IBAction func startPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "GoNext", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

