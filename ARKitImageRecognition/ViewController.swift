/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Main view controller for the AR experience.
*/

import ARKit
import SceneKit
import SpriteKit
import UIKit
import AVKit
import WebKit

class ViewController: UIViewController, ARSCNViewDelegate, WKNavigationDelegate {
    
    var phone: String = ""
    var email: String = ""
    var website: String = ""
    
    @IBOutlet var sceneView: ARSCNView!
    let myView = UIView(frame: CGRect(x: 0, y:0, width: 100, height: 100))
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    /// The view controller that displays the status and "restart experience" UI.
    lazy var statusViewController: StatusViewController = {
        return childViewControllers.lazy.compactMap({ $0 as? StatusViewController }).first!
    }()
    
    /// A serial queue for thread safety when modifying the SceneKit node graph.
    let updateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! +
        ".serialSceneKitQueue")
    
    /// Convenience accessor for the session owned by ARSCNView.
    var session: ARSession {
        return sceneView.session
    }
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.session.delegate = self

        // Hook up status view controller callback(s).
        statusViewController.restartExperienceHandler = { [unowned self] in
            self.restartExperience()
        }
    }
    
    // WKWebView delegate method

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		// Prevent the screen from being dimmed to avoid interuppting the AR experience.
		UIApplication.shared.isIdleTimerDisabled = true

        // Start the AR experience
        resetTracking()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

        session.pause()
	}

    // MARK: - Session management (Image detection setup)
    
    /// Prevents restarting the session while a restart is in progress.
    var isRestartAvailable = true

    /// Creates a new AR configuration to run on the `session`.
    /// - Tag: ARReferenceImage-Loading
	func resetTracking() {
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }
        
        let configuration1 = ARImageTrackingConfiguration()
        let configuration2 = ARWorldTrackingConfiguration()
        
            // Fallback on earlier versions
        configuration1.trackingImages = referenceImages
        configuration2.detectionImages = referenceImages
        session.run(configuration1, options: [.resetTracking, .removeExistingAnchors])

        statusViewController.scheduleMessage("Look around to detect images", inSeconds: 7.5, messageType: .contentPlacement)
	}

    // MARK: - ARSCNViewDelegate (Image detection results)
    /// - Tag: ARImageAnchor-Visualizing
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        let referenceImage = imageAnchor.referenceImage
        updateQueue.async {

        DispatchQueue.main.async {
            let imageName = referenceImage.name ?? ""
            self.statusViewController.cancelAllScheduledMessages()
            self.statusViewController.showMessage("Detected image “\(imageName)”")
            if imageName == "UMass Amherst Card" {
                AmherstID.instance.generateGraphics(referenceImage: referenceImage, node: node)
                self.email = AmherstID.instance.email
                self.phone = AmherstID.instance.phone
                self.website = AmherstID.instance.website
            } else if imageName == "UMass Dartmouth Card" {
                DartmouthID.instance.generateGraphics(referenceImage: referenceImage, node: node)
                self.email = DartmouthID.instance.email
                self.phone = DartmouthID.instance.phone
                self.website = DartmouthID.instance.website
            } else if imageName == "Rollin Rick" {
                RickRoll.instance.generateGraphics(referenceImage: referenceImage, node: node)
            }
        }
    }
    }
    
    func imageFadeAnimation () -> SCNAction{
        return .sequence ([
            .fadeOpacity(to: 0.85, duration: 0.08),
            .fadeOpacity(to: 0.15, duration: 0.08),
            .fadeOpacity(to: 1.0, duration: 0.08)
            ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        /*
         1. Get The Current Touch Location
         2. Check That We Have Touched A Valid Node
         3. Check If The Node Has A Name
         4. Handle The Touch
         */
        let impact = UIImpactFeedbackGenerator()
        
        guard let touchLocation = touches.first?.location(in: sceneView),
            let hitNode = sceneView?.hitTest(touchLocation, options: nil).first?.node,
            let nodeName = hitNode.name
            else {
                print("Nothing was touched")
                return

        }
        //Handle Event Here e.g. PerformSegue
        hitNode.runAction(self.imageFadeAnimation())
        impact.impactOccurred()
        
        if nodeName == "Phone" {
            if let phoneCallURL = URL(string: "tel://\(phone)") {
                
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                }
            }
            
        } else if nodeName == "Email" {
            if let url = URL(string: "mailto:\(email)") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        } else if nodeName == "Messages" {
            UIApplication.shared.open(URL(string: "sms:\(phone)")!, options: [:], completionHandler: nil)
            
        } else if nodeName == "Website" {
            guard let url = URL(string: website) else { return }
            UIApplication.shared.open(url)
            
        } else if nodeName == "Share" {
            let activityVC = UIActivityViewController(activityItems: [phone, email, website], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            
            self.present(activityVC, animated: true, completion: nil)
            
        } else {
            return
        }
        

    }
    
}
