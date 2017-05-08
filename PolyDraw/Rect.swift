//
//  Rect.swift
//  PolyDraw
//
//  Created by Chris Chadillon on 2017-03-02.
//  Copyright © 2017 Chris Chadillon. All rights reserved.
//

import UIKit

class Rect:Shape {
    var theHeight:Double
    var theWidth:Double
    
    init(X:Double, Y:Double, theHeight:Double, theWidth:Double) {
        self.theHeight = theHeight
        self.theWidth = theWidth
        super.init(X: X, Y: Y)
    }
    
    override func draw(_ theContext: CGContext) {
        let rect = CGRect(x: self.X, y: self.Y, width: self.theWidth, height: self.theHeight)
        theContext.addRect(rect)
    }
    
    override func toDictionary()->[String:Double] {
        var dict = super.toDictionary()
        dict["width"] = theWidth
        dict["height"] = theWidth
        dict["type"] = 0.0
        return dict
    }
}

















