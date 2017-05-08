//
//  WaitingViewController.swift
//  PolyDrawNetworked
//
//  Created by Chris Chadillon on 2017-05-08.
//  Copyright © 2017 Chris Chadillon. All rights reserved.
//

import UIKit
import Firebase

class WaitingViewController: UIViewController {
    
    var ref:FIRDatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = FIRDatabase.database().reference()
        
        self.ref?.child("Users").observe(.value, with: { (snapShot) in
            if snapShot.childrenCount == 2 {
                self.dismiss(animated: true, completion: nil)
            }
        })

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
