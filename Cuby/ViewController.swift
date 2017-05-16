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
    
    @IBOutlet weak var userPicture: UIButton!
   
    
    //Variables
    
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    let manager = CLLocationManager()
    
    //Custom colours.
    
    let cubyRed:UIColor = UIColor(red: 180/255.0, green: 20/255.0, blue: 70/255.0, alpha: 1.0)
    
    //viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationLabel.textColor = cubyRed
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        NotificationCenter.default.addObserver(self, selector:#selector(ViewController.rotateIcon), name:NSNotification.Name.UIApplicationWillEnterForeground, object:UIApplication.shared)
        
        NotificationCenter.default.addObserver(self, selector:#selector(ViewController.playVideo), name:NSNotification.Name.UIApplicationDidBecomeActive, object:UIApplication.shared)
        
        //Rotate icon
        
        rotateIcon()
        
        //Play background video
        
        playVideo()
        
        //Location
        
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
                    
                    if place.subThoroughfare != nil && place.thoroughfare != nil && place.locality != nil && place.country != nil {
                        
                        self.locationLabel.text = "\(place.subThoroughfare!) \(place.thoroughfare!), \(place.locality!), \(place.country!)"
                        
                    } else if place.thoroughfare != nil && place.locality != nil && place.country != nil {
                        
                        self.locationLabel.text = "\(place.thoroughfare!), \(place.locality!), \(place.country!)"
                        
                    } else if place.locality != nil && place.country != nil {
                        self.locationLabel.text = "\(place.locality!), \(place.country!)"
                        
                    } else if place.country != nil {
                        self.locationLabel.text = "\(place.country!)"
                        
                    } else {
                        self.locationLabel.text = "\(location.coordinate.latitude), \(location.coordinate.longitude)"
                    }
                    
                }
                
            }
        }
        
        
    
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
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
    
    func rotateIcon() {
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = 360.0
        rotateAnimation.repeatCount = HUGE
        rotateAnimation.duration = 450
        
        
        checkInButton.layer.add(rotateAnimation, forKey: "myAnimationKey");
        
    }
    
    func playVideo() {
        
        let theURL = Bundle.main.url(forResource:"city2", withExtension: "mp4")
        
        avPlayer = AVPlayer(url: theURL!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none
        //avPlayer.rate = 1
        
        avPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = .clear
        view.layer.insertSublayer(avPlayerLayer, at: 0)
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
        avPlayer.play()
        
    }
    
    func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: kCMTimeZero)
    }

    @IBAction func pictureTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "profileSegue", sender: nil)
    }
    
    
    
    
    
    //Final declaration
}
