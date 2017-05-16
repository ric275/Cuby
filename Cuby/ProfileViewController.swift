//
//  ProfileViewController.swift
//  Cuby
//
//  Created by Jack Taylor on 15/05/2017.
//  Copyright © 2017 Jack Taylor. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Custom colours.
    
    let cubyRed:UIColor = UIColor(red: 180/255.0, green: 20/255.0, blue: 70/255.0, alpha: 1.0)
    
    @IBOutlet weak var postsTable: UITableView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsTable.delegate = self
        postsTable.dataSource = self
        
        view.backgroundColor = cubyRed
        
        scoreLabel.textColor = .white
        rankLabel.textColor = .white
        nameLabel.textColor = .white
        userNameLabel.textColor = .white

        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        
        return 10
        
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "hey"
        
        return cell
    
    }
    
    @IBAction func returnToCheckInTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "returnToCheckInSegue", sender: nil)
        
        
    }
    
    
    
    
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     
    
    
    
    }
    
    
}
