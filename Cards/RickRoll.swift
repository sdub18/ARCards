//
//  RollinRick.swift
//  ARKitImageRecognition
//
//  Created by Sam DuBois on 10/14/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import ARKit
import SceneKit
import SpriteKit
import UIKit
import WebKit

class RickRoll {
    
    static let instance = RickRoll()
    
    func generateGraphics(referenceImage: ARReferenceImage, node: SCNNode) {
        let width = CGFloat(referenceImage.physicalSize.width)
        let height = CGFloat(referenceImage.physicalSize.height)
        
        //3. Create An SCNNode To Hold Our Video Player With The Same Size As The Image Target
        let videoHolder = SCNNode()
        let videoHolderGeometry = SCNPlane(width: width, height: height)
        videoHolder.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
        videoHolder.geometry = videoHolderGeometry
        
        //4. Create Our Video Player
        if let videoURL = Bundle.main.url(forResource: "rickRoll", withExtension: "mp4"){
            
            self.setupVideoOnNode(videoHolder, fromURL: videoURL)
        }
        
        //5. Add It To The Hierarchy
        node.addChildNode(videoHolder)
    }
    
    func setupVideoOnNode(_ node: SCNNode, fromURL url: URL){
        
        //1. Create An SKVideoNode
        var videoPlayerNode: SKVideoNode!
        
        //2. Create An AVPlayer With Our Video URL
        let videoPlayer = AVPlayer(url: url)
        
        //3. Intialize The Video Node With Our Video Player
        videoPlayerNode = SKVideoNode(avPlayer: videoPlayer)
        videoPlayerNode.yScale = -1
        
        //4. Create A SpriteKitScene & Postion It
        let spriteKitScene = SKScene(size: CGSize(width: 600, height: 300))
        spriteKitScene.scaleMode = .aspectFit
        videoPlayerNode.position = CGPoint(x: spriteKitScene.size.width/2, y: spriteKitScene.size.height/2)
        videoPlayerNode.size = spriteKitScene.size
        spriteKitScene.addChild(videoPlayerNode)
        
        //6. Set The Nodes Geoemtry Diffuse Contenets To Our SpriteKit Scene
        node.geometry?.firstMaterial?.diffuse.contents = spriteKitScene
        
        //5. Play The Video
        videoPlayerNode.play()
        videoPlayer.volume = 50
        
    }
}
