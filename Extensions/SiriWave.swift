//
//  SiriWave.swift
//  ARKitImageRecognition
//
//  Created by Sam DuBois on 10/13/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

public class SiriWave {
    
    public static let instance = SiriWave()
    
    // MARK: This is the main animation function to layout the design of the Siri Animation. Using CABasicAnimation
    public func prepareSiriAnimation(arcLayer: CAShapeLayer, startPointX: Int, startPointY: Int, width: Int, height: Int, color: UIColor, time: Double) {
        
        // MARK: Starting Animation Path
        var preArc: UIBezierPath {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: startPointX, y: startPointY))
            path.addCurve(to: CGPoint(x: startPointX + width, y: startPointY), controlPoint1: CGPoint(x: startPointX, y: startPointY), controlPoint2: CGPoint(x: startPointX + (width / 2), y: startPointY))
            path.close()
            return path
        }
        
        // MARK: First Animation Path
        var firstArc: UIBezierPath {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: startPointX, y: startPointY))
            path.addCurve(to: CGPoint(x: startPointX + width, y: startPointY), controlPoint1: CGPoint(x: startPointX, y: startPointY), controlPoint2: CGPoint(x: startPointX + (width / 2), y: startPointY - (height * 1/3)))
            path.close()
            return path
        }
        
        // MARK: Second Animation Path
        var secondArc: UIBezierPath {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: startPointX, y: startPointY))
            path.addCurve(to: CGPoint(x: startPointX + width, y: startPointY), controlPoint1: CGPoint(x: startPointX, y: startPointY), controlPoint2: CGPoint(x: startPointX + (width / 2), y: startPointY - (height * (2/3))))
            path.close()
            return path
        }
        
        // MARK: Third Animation Path
        var thirdArc: UIBezierPath {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: startPointX, y: startPointY))
            path.addCurve(to: CGPoint(x: startPointX + width, y: startPointY), controlPoint1: CGPoint(x: startPointX, y: startPointY), controlPoint2: CGPoint(x: startPointX + (width / 2), y: startPointY - height))
            path.close()
            return path
        }
        
        arcLayer.fillColor = color.cgColor
        arcLayer.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        arcLayer.lineWidth = 6
        arcLayer.path = preArc.cgPath
        
        // MARK: Start Animation
        let arcAnimationPre: CABasicAnimation = CABasicAnimation(keyPath: "path")
        arcAnimationPre.fromValue = preArc.cgPath
        arcAnimationPre.toValue = firstArc.cgPath
        arcAnimationPre.beginTime = 0
        arcAnimationPre.duration = 0.25
        
        // MARK: First Animation
        let arcAnimationStart: CABasicAnimation = CABasicAnimation(keyPath: "path")
        arcAnimationStart.fromValue = firstArc.cgPath
        arcAnimationStart.toValue = secondArc.cgPath
        arcAnimationStart.beginTime = arcAnimationPre.beginTime + arcAnimationPre.duration
        arcAnimationStart.duration = 0.25
        
        // MARK: Second Animation
        let arcAnimationSecond: CABasicAnimation = CABasicAnimation(keyPath: "path")
        arcAnimationSecond.fromValue = secondArc.cgPath
        arcAnimationSecond.toValue = thirdArc.cgPath
        arcAnimationSecond.beginTime = arcAnimationStart.beginTime + arcAnimationStart.duration
        arcAnimationSecond.duration = 0.25
        
        // MARK: Animate the arcs in a collected group
        let arcAnimationGroup: CAAnimationGroup = CAAnimationGroup()
        arcAnimationGroup.animations = [arcAnimationPre, arcAnimationStart, arcAnimationSecond]
        arcAnimationGroup.duration = arcAnimationSecond.beginTime + arcAnimationSecond.duration
        arcAnimationGroup.repeatDuration = time
        arcAnimationGroup.autoreverses = true
        arcAnimationGroup.fillMode = kCAFillModeForwards
        arcAnimationGroup.isRemovedOnCompletion = false
        arcLayer.add(arcAnimationGroup, forKey: nil)
    }
    
    // MARK: Creates two versions of each animation. One in the positive direction and another in the negative direction.
    public func generateSiriPulse (positiveArcLayer: CAShapeLayer, negativeArcLayer: CAShapeLayer, width: Int, height: Int, startPointX: Int, color: UIColor, time: Double) {
        // The upward and downward direction of one siri "pulse"
        prepareSiriAnimation(arcLayer: positiveArcLayer, startPointX: startPointX, startPointY: 614, width: width, height: height, color: color, time: time)
        prepareSiriAnimation(arcLayer: negativeArcLayer, startPointX: startPointX, startPointY: 614, width: width, height: height * -1, color: color, time: time)
    }
    
    // MARK: A Simple UIView Animation to move the view down when the Question Button is pushed
    public func moveDown(View: UIView) {
        
        UIView.animate(withDuration: Double(0.5), animations: {
            View.frame = CGRect(x: 10, y: -40, width: 350, height: 300)
        })
    }
    
}
