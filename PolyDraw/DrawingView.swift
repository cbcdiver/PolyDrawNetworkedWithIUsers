//
//  DrawingView.swift
//  PolyDraw
//
//  Created by Chris Chadillon on 2017-03-02.
//  Copyright © 2017 Chris Chadillon. All rights reserved.
//

import UIKit
import Firebase

class DrawingView: UIView {

    var shapeType = 0
    var theShapes = [Shape]()
    var ref:FIRDatabaseReference?
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let possibleContext = UIGraphicsGetCurrentContext()
        
        if let theContext = possibleContext {
            theContext.setLineWidth(1.0)
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let components:[CGFloat] = [0.0, 0.0, 1.0, 1.0]
            let color = CGColor(colorSpace: colorSpace, components: components)
            theContext.setStrokeColor(color!)
            
            for aShape in self.theShapes {
                aShape.draw(theContext)
            }
            
            theContext.strokePath()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        let location = touch.location(in: self)
        
        let shape:Shape?
        
        if shapeType == 0 {
            shape = Rect(X:Double(location.x),
                                       Y:Double(location.y),
                                       theHeight: 20,
                                       theWidth:20)
        } else {
            shape = Oval(X:Double(location.x),
                                       Y:Double(location.y),
                                       theHeight: 20,
                                       theWidth:20)
        }
        
        ref?.child("Shapes").childByAutoId().setValue(shape?.toDictionary())
        self.theShapes.append(shape!)
        
        self.setNeedsDisplay()
    }
 
}





