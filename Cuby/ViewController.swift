//
//  ViewController.swift
//  Cuby
//
//  Created by Jack Taylor on 02/05/2017.
//  Copyright © 2017 Jack Taylor. All rights reserved.
//

import UIKit
import AVFoundation
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
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
    let manager = CLLocationManager()
    
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
        
        let theURL = Bundle.main.url(forResource:"city2", withExtension: "mp4")
        
        avPlayer = AVPlayer(url: theURL!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none
        avPlayer.rate = 1
        
        avPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = .clear
        view.layer.insertSublayer(avPlayerLayer, at: 0)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
        
        //Map
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()

        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
               
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil {
                print("error")
            } else {
                if let place = placemark?[0] {
                    
                    if place.subThoroughfare != nil {
                        
                        self.locationLabel.text = "\(place.subThoroughfare!) \(place.thoroughfare!), \(place.locality!), \(place.country!)"
                        
                        
                    } else {
                        self.locationLabel.text = "Could not fetch location"
                    }
                    
                }
                
                }
            }
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
