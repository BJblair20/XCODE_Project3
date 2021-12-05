//
//  BreakModel.swift
//  WSUBreak3D
//
//  Created by wsucatslabs on 10/29/21.
//

import SceneKit

class BreakModel : NSObject, SCNSceneRendererDelegate, SCNPhysicsContactDelegate {
    var scene = SCNScene()
    var Player : SCNNode?
    //var ball : SCNNode?
    //var ballStartPosition = SCNVector3()
    
    func load() {
        scene = SCNScene(named: "art.scnassets/Break.scn")!
        scene.physicsWorld.contactDelegate = self
        Player = scene.rootNode.childNode(withName: "Player", recursively: true)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        let respawnY = Float(-28)
        //if(ball!.presentation.position.y < respawnY) {
            //ball!.physicsBody?.velocity = SCNVector3Zero
            //ball!.position = ballStartPosition
        //} 
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        //if(contact.nodeA == ball) {
            //print(contact.nodeB.name!)
            //contact.nodeB.removeFromParentNode()
        //} else if(contact.nodeB == ball) {
            //print(contact.nodeA.name!)
            //contact.nodeA.removeFromParentNode()
        //}
    }
    
    //x position: Float
    func movePlayer(translation: CGPoint) {
        Player!.physicsBody?.isAffectedByGravity=false
        let minX = Float(-90) // experimentally determined
        let maxX = Float(90) // experimentally determined
        //let newX = min(max(Float(position), minX), maxX)
        let newX=min(max(Float(translation.x),-180),180)*0.05
        //let newY=min(max(Float(translation.y),-180),180)*0.05
        let newY=Float(translation.y)
        //paddle!.position.y
        Player!.position = SCNVector3(newX, newY, 0)
    }
}
