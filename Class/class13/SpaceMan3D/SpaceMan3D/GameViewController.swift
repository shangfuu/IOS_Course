//
//  GameViewController.swift
//  SpaceMan3D
//
//  Created by mac07 on 2020/6/3.
//  Copyright © 2020 NTUST. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import CoreMotion

class GameViewController: UIViewController {
    
    var sceneView: SCNView!
    var mainScene: SCNScene!
    var cameraNode: SCNNode!
    
    // extension
    var touchCount: Int?
    var motionManager: CMMotionManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScene = createMainScene()
        sceneView = self.view as? SCNView
        sceneView.scene = mainScene
        sceneView.backgroundColor = UIColor.black
        
        sceneView.showsStatistics = true
        sceneView.allowsCameraControl = true
        
        createMainCamera()
        sceneView.delegate = self
    }
    
    func createMainScene() -> SCNScene {
        let mainScene = SCNScene(named: "art.scnassets/hero.dae")
        mainScene!.rootNode.addChildNode(createFloorNode())
        mainScene?.rootNode.addChildNode(createEnemy())
        mainScene?.rootNode.addChildNode(Collectable.pyramidNode())
        mainScene?.rootNode.addChildNode(Collectable.sphereNode())
        mainScene?.rootNode.addChildNode(Collectable.boxNode())
        mainScene?.rootNode.addChildNode(Collectable.tubeNode())
        mainScene?.rootNode.addChildNode(Collectable.cylinderNode())
        mainScene?.rootNode.addChildNode(Collectable.torusNode())
        setupLighting(mainScene!)
        return mainScene!
    }
    
    func createFloorNode () -> SCNNode {
        let floorNode = SCNNode()
        floorNode.geometry = SCNFloor()
        floorNode.geometry?.firstMaterial?.diffuse.contents = "Floor"
        return floorNode
    }
    
    func createEnemy() ->SCNNode {
        let enemyScene = SCNScene(named: "art.scnassets/enemy.dae")
        let enemyNode = enemyScene?.rootNode.childNode(withName: "enemy", recursively: true)
        enemyNode?.name = "enemy"
        enemyNode?.position = SCNVector3(x: 40, y: 10, z: 30)
        enemyNode?.rotation = SCNVector4(x: 0, y: 1, z: 0, w: Float(.pi/4/2.8))
        
        let action = SCNAction.repeatForever(SCNAction.sequence([SCNAction.rotateBy(x: 0, y: 10, z: 0, duration: 1), SCNAction.rotateBy(x: 0, y: -10, z: 0, duration: 1)]))
        enemyNode?.runAction(action)
        return enemyNode!
    }
    
    func setupLighting(_ scene: SCNScene) {
        let ambientLight = SCNNode()
        ambientLight.light = SCNLight()
        ambientLight.light?.type = SCNLight.LightType.ambient
        ambientLight.light?.color = UIColor.green
        scene.rootNode.addChildNode(ambientLight)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = SCNLight.LightType.spot
        lightNode.light?.castsShadow = true
        lightNode.light?.color = UIColor(white: 0.8, alpha: 1.0)
        lightNode.position = SCNVector3Make(30, 30, 15)
        lightNode.light?.spotInnerAngle = 0
        lightNode.light?.spotOuterAngle = 60
        lightNode.light?.zFar = 1000
        scene.rootNode.addChildNode(lightNode)
    }
    
    func createMainCamera(){
        cameraNode = SCNNode()
        cameraNode.name = "mainCamera"
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.zFar = 1000
        cameraNode.position = SCNVector3(x: 0, y: 15, z: 50)
        mainScene.rootNode.childNode(withName: "hero", recursively: true)?.addChildNode(cameraNode)
    }
    
}

extension GameViewController: SCNSceneRendererDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let taps = event?.allTouches
        touchCount = taps?.count
        print(touchCount!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchCount = 0
        print(touchCount!)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didSimulatePhysicsAtTime time: TimeInterval) {
        let moveDistance = Float(10.0)
        let moveSpeed = TimeInterval(1.0)
        let heroNode = mainScene.rootNode.childNode(withName: "hero", recursively: true)
        let currentX = heroNode?.position.x
        let currentY = heroNode?.position.y
        let currentZ = heroNode?.position.z
        
        if touchCount == 1 {
            let action = SCNAction.move(to: SCNVector3(currentX!, currentY!, currentZ! - moveDistance), duration: moveSpeed)
            heroNode?.runAction(action)
        }
        else if touchCount == 2 {
            let action = SCNAction.move(to: SCNVector3(currentX!, currentY!, currentZ! + moveDistance), duration: moveSpeed)
            heroNode?.runAction(action)
        }
        else if touchCount == 4 {
            let action = SCNAction.move(to: SCNVector3(0, 0, 0), duration: moveSpeed)
            heroNode?.runAction(action)
        }
        
    }

    
    func setupAccelerometer() {
        motionManager = CMMotionManager()
        if motionManager.isAccelerometerActive{
            motionManager.accelerometerUpdateInterval = 1/60.0
            motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
                let heroNode = self.mainScene.rootNode.childNode(withName: "hero", recursively: true)?.presentation
                let currentX = heroNode?.position.x
                let currentY = heroNode?.position.y
                let currentZ = heroNode?.position.z
                let threshold = 0.20
                
                // moving right
                if (data?.acceleration.y)! < -threshold || (data?.acceleration.y)! > threshold {
                    let destinationX = (Float((data?.acceleration.y)!) * 10.0 + Float(currentX!))
                    let destinationY = Float(currentY!)
                    let destinationZ = Float(currentZ!)
                    let action = SCNAction.move(to: SCNVector3(destinationX,destinationY,destinationZ), duration: 1)
                    heroNode?.runAction(action)
                }
                
                
            }
        }
    }
    
}
