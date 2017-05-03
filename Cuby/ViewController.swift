//
//  ViewController.swift
//  Cuby
//
//  Created by Jack Taylor on 02/05/2017.
//  Copyright © 2017 Jack Taylor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var checkInButton: UIButton!
    
    @IBOutlet weak var topCheckInButton: UIButton!
    
    @IBOutlet weak var locationLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = 360.0
        rotateAnimation.repeatCount = HUGE
        rotateAnimation.duration = 450
        
        checkInButton.layer.add(rotateAnimation, forKey: "myAnimationKey");
        
        

        
    }

}

