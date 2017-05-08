//
//  ViewController.swift
//  PolyDraw
//
//  Created by Chris Chadillon on 2017-03-02.
//  Copyright © 2017 Chris Chadillon. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    var ref:FIRDatabaseReference?
    
    @IBAction func shapeChosen(_ sender: UISegmentedControl) {
        self.drawingView.shapeType = sender.selectedSegmentIndex
    }
    
    @IBOutlet weak var drawingView: DrawingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.drawingView.ref = FIRDatabase.database().reference()
        self.ref = self.drawingView.ref
        
        ref?.child("Users").childByAutoId().setValue("A User")
        self.ref?.child("Users").observeSingleEvent(of: .value, with: { (snapShot) in
            if snapShot.childrenCount == 1 {
               self.performSegue(withIdentifier: "wait", sender: self)
            }
        })

        self.ref?.child("Shapes").observe(.childAdded, with: { (snapShot) in
            let dict = snapShot.value as! [String:Double]
            
            let shape:Shape?
            if dict["type"]! == 0 {
                shape = Rect(X:dict["X"]!,
                             Y:dict["Y"]!,
                             theHeight: dict["height"]!,
                             theWidth:dict["width"]!)
            } else {
                shape = Oval(X:dict["X"]!,
                             Y:dict["Y"]!,
                             theHeight: dict["height"]!,
                             theWidth:dict["width"]!)
            }
            
            self.drawingView.theShapes.append(shape!)
            self.drawingView.setNeedsDisplay()
            
        })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Little function to show an alert
    func showAlert(errorMessage:String, title:String = "Error") {
        let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

