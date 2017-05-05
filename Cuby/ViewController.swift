//
//  ViewController.swift
//  Cuby
//
//  Created by Jack Taylor on 02/05/2017.
//  Copyright © 2017 Jack Taylor. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //Hide Status Bar
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //Outlets

    @IBOutlet weak var checkInButton: UIButton!
    
    @IBOutlet weak var topCheckInButton: UIButton!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    //Variables
    
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    
    //viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Rotate icon
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = 360.0
        rotateAnimation.repeatCount = HUGE
        rotateAnimation.duration = 450
        
        checkInButton.layer.add(rotateAnimation, forKey: "myAnimationKey");
        
        //Play background video
        
        let theURL = Bundle.main.url(forResource:"test2", withExtension: "mp4")
        
        avPlayer = AVPlayer(url: theURL!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none
        avPlayer.rate = 0.25
        
        avPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = .clear
        view.layer.insertSublayer(avPlayerLayer, at: 0)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)

        
    }

    func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: kCMTimeZero)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        avPlayer.play()
        paused = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.pause()
        paused = true
    }
}


