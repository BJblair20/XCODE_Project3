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
    let model = BreakModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.load()

        // setup SCNView
        scnView = self.view as? SCNView
        scnView!.scene = model.scene
        scnView!.delegate = model
    }
    
    @IBAction func movePaddle(recognizer : UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let newX = min(max(Float(translation.x), -180), 180) * 0.05
        let newY = Float(translation.y) * 0.05
        model.movePlayer(translation: translation)
        
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
