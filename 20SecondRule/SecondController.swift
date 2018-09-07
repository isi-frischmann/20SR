//
//  SecondController.swift
//  20SecondRule
//
//  Created by Neil Sood on 9/6/18.
//  Copyright © 2018 Neil Sood. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class SecondController: UIViewController, AVAudioPlayerDelegate {
    
//    variables for core motion
    var motionManager = CMMotionManager()
    let opQueue = OperationQueue()
    
//    variables for swipe
    var numberOfTouchesRequired: Int = 1
    
//    variables for audio
    var btwPlayer: AVAudioPlayer?
    var neutral = false
    var isPlaying: Bool = true
    

    
    func playSound(_ name: String) {
        
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
                // The following line is required for the player to work on iOS 11. Change the file type accordingly
            btwPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            // iOS 10 and earlier require the following line:
//            btwPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3)
            guard let player = btwPlayer else { return }
            switch name {
            case "btw":
                btwPlayer?.volume = 1.1
            case "google":
                btwPlayer?.volume = 0.3
            case "help":
//            case "moo":
                btwPlayer?.volume = 0.2
            default:
                btwPlayer?.volume = 0.3
            }
            if isPlaying == true {
                player.play()
            }
            else {
                player.stop()
            }
        } catch {
            //            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        swipe
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        // Do any additional setup after loading the view.
    }

//    swipe function
    @IBAction func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.down {
            print("Swipe Down")
            dismiss(animated: true, completion: nil)
        }
        if gesture.direction == UISwipeGestureRecognizerDirection.left {
            print("Swipe Left")
//            dismiss(animated: true, completion: nil)
        }
        if gesture.direction == UISwipeGestureRecognizerDirection.up {
            print("Swipe Up")
            swipeTeam(gesture)
        }
        
    }
    
    @IBAction func swipeTeam(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "GoTeam", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if motionManager.isDeviceMotionAvailable {
            print("We can detect device motion")
            startReadingMotionData()
            isPlaying = true
        }
        else {
            print("We cannot detect device motion")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        isPlaying = false
    }

    
    func startReadingMotionData() {
        // set read speed
        motionManager.deviceMotionUpdateInterval = 0.1
        // start reading
        motionManager.startDeviceMotionUpdates(to: opQueue) {
            (data: CMDeviceMotion?, error: Error?) in
            
            if let mydata = data {
                if mydata.gravity.x >= -0.1 && mydata.gravity.y <= 0.1 && mydata.gravity.y >= -0.1 {
                    self.neutral = true
                }
                if self.neutral {
                    if mydata.gravity.y >= 0.60 {
                        self.playSound("btw")
                        self.neutral = false
                    }
                    if mydata.gravity.x <= -0.60 {
                        self.playSound("google")
                        self.neutral = false
                    }
                    if mydata.gravity.x >= 0.60 {
                        self.playSound("help")
                        self.neutral = false
                    }
                    if mydata.gravity.y <= -0.60 {
                        self.playSound("gotit")
                        self.neutral = false
                    }
                }
            }
        }
    }
    
    func degrees(_ radians: Double) -> Double {
        return 180/Double.pi * radians
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
