//
//  NodeCentralForce.swift
//  Physics Lav
//
//  Created by Ivan Sabino on 18/02/20.
//  Copyright © 2020 Ivan Sabino. All rights reserved.
//

import Foundation
import SceneKit

class NodeCentralForce: SCNNode{
    
    
    /// Creating a Sphere Node with a central force of attraction
    /// - Parameters:
    ///   - position: position of sphere
    ///   - forceIntensity: intensity of the central force
    ///   - radius: radius of sphere
     init(position:SCNVector3, forceIntensity: CGFloat, radius: CGFloat, velocity: SCNVector3){
        super.init()
        let geometry = SCNSphere(radius: radius)
        let physicalShape = SCNPhysicsShape(geometry: geometry, options: nil)
       
        self.geometry = geometry
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: physicalShape)
        self.physicsField = SCNPhysicsField.radialGravity()
        self.physicsField?.strength = forceIntensity
        self.position = position
        self.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        self.physicsBody?.velocity = velocity
        self.physicsBody?.isAffectedByGravity = true
        self.physicsBody?.contactTestBitMask = CollisionsMaks.ball
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
