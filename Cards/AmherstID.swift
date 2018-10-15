//
//  AmherstID.swift
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

class AmherstID {
    
    static let instance = AmherstID()
    
    var phone: String = "5088371117"
    var email: String = "samdubois18@icloud.com"
    var website: String = "https://www.linkedin.com/in/samuel-dubois/"
    
    func generateGraphics(referenceImage: ARReferenceImage, node: SCNNode) {
        let sceneOne = self.createSKScene(color: #colorLiteral(red: 0.1960784314, green: 0.462745098, blue: 0.9176470588, alpha: 1), image: "Mail", ratio: 2)
        let materialsOne = self.createMaterials(scene: sceneOne)
        
        let plane = SCNPlane(width: referenceImage.physicalSize.width / 4, height: referenceImage.physicalSize.width / 4)
        plane.cornerRadius = referenceImage.physicalSize.width / 4
        plane.materials = [materialsOne]
        
        let firstPlaneNode = SCNNode(geometry: plane)
        firstPlaneNode.opacity = 1
        firstPlaneNode.eulerAngles.x = -.pi / 2
        firstPlaneNode.runAction(self.imageAnimation(x: 0, y: 0, z: -0.04, wait: 0.5))
        firstPlaneNode.position = SCNVector3(referenceImage.physicalSize.width / 2.75, 0, 0)
        firstPlaneNode.name = "Email"
        node.addChildNode(firstPlaneNode)
        
        // WIFI PLANE NODE
        let sceneTwo = self.createSKScene(color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), image: "screenshot", ratio: 1.2)
        let materialsTwo = self.createMaterials(scene: sceneTwo)
        
        let planeTwo = SCNPlane(width: referenceImage.physicalSize.width , height: referenceImage.physicalSize.width )
        planeTwo.cornerRadius = referenceImage.physicalSize.width / 10
        planeTwo.materials = [materialsTwo]
        
        let secondPlaneNode = SCNNode(geometry: planeTwo)
        secondPlaneNode.opacity = 1
        secondPlaneNode.eulerAngles.x = -.pi / 2
        secondPlaneNode.runAction(self.imageAnimation(x: 0, y: 0, z: 0.07, wait: 0.5))
        secondPlaneNode.position = SCNVector3(0, 0, 0)
        secondPlaneNode.name = "Website"
        node.addChildNode(secondPlaneNode)
        
        // EMAIL PLANE NODE
        let sceneThree = self.createSKScene(color: #colorLiteral(red: 0.3803921569, green: 0.8078431373, blue: 0.3058823529, alpha: 1), image: "Cellular", ratio: 2)
        let materialsThree = self.createMaterials(scene: sceneThree)
        
        let thirdPlane = SCNPlane(width: referenceImage.physicalSize.width / 4, height: referenceImage.physicalSize.width / 4)
        thirdPlane.cornerRadius = referenceImage.physicalSize.width / 4
        thirdPlane.materials = [materialsThree]
        
        let thirdPlaneNode = SCNNode(geometry: thirdPlane)
        thirdPlaneNode.opacity = 1
        thirdPlaneNode.eulerAngles.x = -.pi / 2
        thirdPlaneNode.runAction(self.imageAnimation(x: 0, y: 0, z: -0.04, wait: 0.5))
        thirdPlaneNode.position = SCNVector3(referenceImage.physicalSize.width / 15, 0, 0)
        thirdPlaneNode.name = "Phone"
        node.addChildNode(thirdPlaneNode)
        
        // CONTACTS PLANE NODE
        let sceneFour = self.createSKScene(color: #colorLiteral(red: 0.3803921569, green: 0.8078431373, blue: 0.3058823529, alpha: 1), image: "messages", ratio: 2)
        let materialsFour = self.createMaterials(scene: sceneFour)
        
        let fourthPlane = SCNPlane(width: referenceImage.physicalSize.width / 4, height: referenceImage.physicalSize.width / 4)
        fourthPlane.cornerRadius = referenceImage.physicalSize.width / 4
        fourthPlane.materials = [materialsFour]
        
        let fourthPlaneNode = SCNNode(geometry: fourthPlane)
        fourthPlaneNode.opacity = 1
        fourthPlaneNode.eulerAngles.x = -.pi / 2
        fourthPlaneNode.runAction(self.imageAnimation(x: 0.055, y: 0, z: 0, wait: 0.5))
        fourthPlaneNode.position = SCNVector3(0, 0, -1 * referenceImage.physicalSize.height / 4)
        fourthPlaneNode.name = "Messages"
        node.addChildNode(fourthPlaneNode)
        
        // SHARE PLANE NODE
        let sceneFive = self.createSKScene(color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), image: "Share", ratio: 2)
        let materialsFive = self.createMaterials(scene: sceneFive)
        
        let fifthPlane = SCNPlane(width: referenceImage.physicalSize.width / 4, height: referenceImage.physicalSize.width / 4)
        fifthPlane.cornerRadius = referenceImage.physicalSize.width / 4
        fifthPlane.materials = [materialsFive]
        
        let fifthPlaneNode = SCNNode(geometry: fifthPlane)
        fifthPlaneNode.opacity = 1
        fifthPlaneNode.eulerAngles.x = -.pi / 2
        fifthPlaneNode.runAction(self.imageAnimation(x: 0.055, y: 0, z: 0, wait: 0.5))
        fifthPlaneNode.position = SCNVector3(0, 0, referenceImage.physicalSize.height / 4)
        fifthPlaneNode.name = "Share"
        node.addChildNode(fifthPlaneNode)
        
        // AUDIO PLANE NODE
        let width = CGFloat(referenceImage.physicalSize.width / 3)
        let height = CGFloat(referenceImage.physicalSize.height / 2)
        
        //3. Create An SCNNode To Hold Our Video Player With The Same Size As The Image Target
        let videoHolder = SCNNode()
        let videoHolderGeometry = SCNPlane(width: width, height: height)
        videoHolder.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
        videoHolder.geometry = videoHolderGeometry
        videoHolder.position = SCNVector3(referenceImage.physicalSize.width / -3, 0, -0.01)
        videoHolder.localRotate(by: SCNQuaternion(x: 0, y: 0, z: -0.7071, w: 0.7071))
        
        //4. Create Our Video Player
        if let videoURL = Bundle.main.url(forResource: "profileVideo", withExtension: "mov"){
            
            self.setupVideoOnNode(videoHolder, fromURL: videoURL)
        }
        
        //5. Add It To The Hierarchy
        node.addChildNode(videoHolder)
    }

    func createMaterials(scene: SKScene) -> SCNMaterial {
        let materialsOne = SCNMaterial()
        materialsOne.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1), 0, 1, 0)
        materialsOne.diffuse.contents = scene
        materialsOne.isDoubleSided = true
        
        return materialsOne
    }

    func imageAnimation (x: CGFloat, y: CGFloat, z: CGFloat, wait: Double) -> SCNAction {
        return .sequence ([
            .fadeOpacity(to: 0, duration: wait),
            .fadeOpacity(to: 0.85, duration: 0.10),
            .moveBy(x: x, y: y, z: z, duration: 0.05),
            .fadeOpacity(to: 0.85, duration: 0.10),
            .fadeOpacity(to: 0.15, duration: 0.10),
            .fadeOpacity(to: 1.0, duration: 0.10)
            ])
    }

    func createSKScene(color: UIColor, image: String, ratio: CGFloat) -> SKScene{
        let skScene = SKScene(size: CGSize(width: 1000, height: 1000))
        skScene.backgroundColor = UIColor.clear
        
        // Image Shield
        let image = SKSpriteNode.init(imageNamed: "\(image).jpg")
        image.position = CGPoint(x: skScene.frame.width / 2, y: skScene.frame.height / 2)
        image.setScale(ratio)
        
        // Create the Node Rectangle
        let bg = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 1000, height: 1000))
        bg.fillColor = color
        bg.strokeColor = color
        bg.lineWidth = 10
        
        // Add All the Objects onto the scene
        skScene.addChild(bg)
        skScene.addChild(image)
        
        return skScene
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
