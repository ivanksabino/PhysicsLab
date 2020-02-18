//
//  GameViewController.swift
//  Physics Lav
//
//  Created by Ivan Sabino on 14/02/20.
//  Copyright © 2020 Ivan Sabino. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController, SCNSceneRendererDelegate {
    let scnView = SCNView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene(named: "art.scnassets/physicsLab.scn")!
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 10, y: 10, z: 10)
        cameraNode.camera.
        
//        // create and add a light to the scene
//        let lightNode = SCNNode()
//        lightNode.light = SCNLight()
//        lightNode.light!.type = .omni
//        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
//        scene.rootNode.addChildNode(lightNode)
//
//        // create and add an ambient light to the scene
//        let ambientLightNode = SCNNode()
//        ambientLightNode.light = SCNLight()
//        ambientLightNode.light!.type = .ambient
//        ambientLightNode.light!.color = UIColor.darkGray
//        scene.rootNode.addChildNode(ambientLightNode)
//
//        // retrieve the ship node
//
        // retrieve the SCNView
        self.view = scnView
        
        // set the scene to the view
        scnView.scene = scene
        scnView.delegate = self
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        scnView.debugOptions = SCNDebugOptions.showPhysicsShapes
        // configure the view
        scnView.backgroundColor = UIColor.black
    
        
        
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        
        let ballGeometry = SCNSphere(radius: 0.1)
        
        let ballNode = SCNNode(geometry: ballGeometry)
        ballNode.position = SCNVector3(0, 7, -1.1)
        
        ballNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: SCNSphere(radius: 0.1), options: nil))
        ballNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        ballNode.physicsBody?.isAffectedByGravity = true

        self.scnView.scene?.rootNode.addChildNode(ballNode)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

}
