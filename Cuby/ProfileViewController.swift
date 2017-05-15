//
//  ProfileViewController.swift
//  Cuby
//
//  Created by Jack Taylor on 15/05/2017.
//  Copyright © 2017 Jack Taylor. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var postsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsTable.delegate = self
        postsTable.dataSource = self
        
        view.backgroundColor = .red
        
        
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
