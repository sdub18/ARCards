//
//  UIViewExtensions.swift
//  ARKitImageRecognition
//
//  Created by Sam DuBois on 7/16/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import SceneKit

extension SKNode {
    
    func addGradientLayer(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        
        self.scene?.view?.layer.addSublayer(gradientLayer)
    }
    
}
