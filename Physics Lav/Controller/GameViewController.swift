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
//        let scene = SCNScene(named: "art.scnassets/physicsLab.scn")!
        
        scnView.scene = SCNScene()
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scnView.scene?.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 10, z: 0)
        
                // create and add a light to the scene
                let lightNode = SCNNode()
                lightNode.light = SCNLight()
                lightNode.light!.type = .omni
                lightNode.position = SCNVector3(x: -10, y: 10, z: -10)
                scnView.scene?.rootNode.addChildNode(lightNode)
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
        
        // set the scene to the view
//        scnView.scene = scene
        scnView.delegate = self
        scnView.scene?.physicsWorld.contactDelegate = self
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        scnView.debugOptions = SCNDebugOptions.showPhysicsShapes
        // configure the view
        scnView.backgroundColor = UIColor.white
        
        let plane = SCNNode(geometry: SCNPlane(width: 30, height: 30))
        plane.position = SCNVector3(0, 0, 0)
        plane.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: SCNPlane(width: 30, height: 30), options: nil))
        plane.physicsBody?.contactTestBitMask = CollisionsMaks.floor
        plane.geometry?.firstMaterial?.diffuse.contents = UIColor.black
        plane.rotation.z = .pi/2
        scnView.scene?.rootNode.addChildNode(plane)
        self.view = scnView

        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        
        //MARK: Ball in the Half
        //        let ballGeometry = SCNSphere(radius: 0.1)
        //
        //        let ballNode = SCNNode(geometry: ballGeometry)
        //        ballNode.position = SCNVector3(0, 7, -1.1)
        //
        //        ballNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: SCNSphere(radius: 0.1), options: nil))
        //        ballNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        //        ballNode.physicsBody?.isAffectedByGravity = true
        //
        //        self.scnView.scene?.rootNode.addChildNode(ballNode)
        
        //MARK: Spheres atracting themselves
        createSphere(numberOfBalls: 15)
        
    }
    
    func createSphere(numberOfBalls: Int){
        
        for i in 0 ..< 15{
            let positionArray = SCNVector3(CGFloat.random(in: -7 ..< 7), CGFloat.random(in: 0 ..< 7), CGFloat.random(in: -7 ..< 7))
            let velocityArray = SCNVector3(0, 0, 0)
            let node: NodeCentralForce = NodeCentralForce(position: positionArray, forceIntensity: 1, radius: 0.5, velocity: velocityArray)
            scnView.scene?.rootNode.addChildNode(node)
            
        }
        
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

extension GameViewController: SCNPhysicsContactDelegate{
    
    
}
