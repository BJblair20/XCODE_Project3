//
//  GameViewController.swift
//  WSUBreak3D
//
//  Created by wsucatslabs on 10/29/21.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    var scnView : SCNView?
    var paddle : SCNNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene(named: "art.scnassets/Break.scn")!
        paddle = scene.rootNode.childNode(withName: "Paddle", recursively: true)
        // retrieve the SCNView
        scnView = self.view as? SCNView
        
        // set the scene to the view
        scnView!.scene = scene
        
        // show statistics such as fps and timing information
        scnView!.showsStatistics = true
        
        // configure the view
        //scnView!.backgroundColor = UIColor.black
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView!.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func movePaddle(recognizer : UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let newX = min(max(Float(translation.x), -180), 180) * 0.05
        paddle!.position = SCNVector3(newX, paddle!.position.y, 0)
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            // get its material
            let material = result.node.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.red
            
            SCNTransaction.commit()
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
