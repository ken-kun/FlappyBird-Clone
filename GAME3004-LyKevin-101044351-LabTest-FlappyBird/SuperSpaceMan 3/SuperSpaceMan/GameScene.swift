//
//  GameScene.swift
//  SuperSpaceMan
//
//  Created by Mark Meritt on 2019-02-04.
//  Copyright © 2019 Mark Meritt. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

struct PhysicsType {
    static let flappybird: UInt32 = 0x1 << 1
    static let ground: UInt32 = 0x1 << 2
    static let pipe: UInt32 = 0x1 << 3
    static let score: UInt32 = 0x1 << 4
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ground = SKSpriteNode()
    var background = SKSpriteNode()
    var flappyBird = SKSpriteNode()
    var pipePair = SKNode()
    var moveAndRemove = SKAction()
    var gameStart = Bool()
    var score = Int()
    
    var gameNode = SKSpriteNode()
    var overNode = SKSpriteNode()
    var shareButton = SKSpriteNode()
    var okButton = SKSpriteNode()
    var getNode = SKSpriteNode()
    var readyNode = SKSpriteNode()
    var birdIcon = SKSpriteNode()
    var arrowNode = SKSpriteNode()
    var handNode = SKSpriteNode()
    var tapNode = SKSpriteNode()
    var pauseButton = SKSpriteNode()
    var resumeButton = SKSpriteNode()
    
    
    
    var death = Bool()
    
    let scoreLabel = SKLabelNode()
    var audioPlayer = AVAudioPlayer()
    var scoreSound = AVAudioPlayer()
    var TextureAtlas = SKTextureAtlas()
    var TextureArray = [SKTexture]()
    
    

    override func didMove(to view: SKView) {
        
        
       createScene()
        
        
    }
    
    
    
    func restartScene()
    {
        self.removeAllChildren()
        self.removeAllActions()
        death = false
        gameStart = false
        score = 0
        createScene()
    }
    
    func createScene()
    {
        self.physicsWorld.contactDelegate = self
        
        
        
        background = SKSpriteNode(imageNamed: "background.png")
        background.setScale(3)
        background.position = CGPoint(x: self.frame.width/2, y: background.frame.height/1.5)
        self.addChild(background)
        
        
        
        
        ground = SKSpriteNode(imageNamed: "ground.png")
        ground.setScale(3)
        ground.position = CGPoint(x: self.frame.width/2, y: 0 + ground.frame.height/3)
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.categoryBitMask = PhysicsType.ground
        ground.physicsBody?.collisionBitMask = PhysicsType.flappybird
        ground.physicsBody?.contactTestBitMask = PhysicsType.flappybird
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.isDynamic = false
        
        ground.zPosition = 3
        self.addChild(ground)
        
        
        TextureAtlas = SKTextureAtlas(named: "flappybird")
        for i in 1...3{
            
            let Name = "flappybird_\(i)"
            TextureArray.append(SKTexture(imageNamed: Name))
            
        }
        
        
        
        flappyBird = SKSpriteNode(imageNamed: "flappybird_1" )
        flappyBird.setScale(3)
        flappyBird.position = CGPoint(x:self.frame.width/2 - flappyBird.frame.width, y: self.frame.height/2)
        flappyBird.physicsBody = SKPhysicsBody(circleOfRadius: flappyBird.frame.height / 2 )
        flappyBird.physicsBody?.categoryBitMask = PhysicsType.flappybird
        flappyBird.physicsBody?.collisionBitMask = PhysicsType.ground | PhysicsType.pipe
        flappyBird.physicsBody?.contactTestBitMask = PhysicsType.ground | PhysicsType.pipe | PhysicsType.score
        flappyBird.physicsBody?.affectedByGravity = false
        flappyBird.physicsBody?.isDynamic = true;
        
        flappyBird.zPosition = 2
        flappyBird.run(SKAction.repeatForever(SKAction.animate(with: TextureArray, timePerFrame: 0.1, resize: true, restore: true)))
    
        self.addChild(flappyBird)
        
        
        
        scoreLabel.position = CGPoint(x: self.frame.width / 2 , y: self.frame.height/2 + 350)
        scoreLabel.zPosition = 5
        scoreLabel.text = "\(score)"
        self.addChild(scoreLabel)
        
        
        //let deathSound = Bundle.main.path(forResource: "Slap", ofType: "mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Slap", ofType: "mp3")!))
        }
        catch {
            print(error)
        }
        
        
        do {
            scoreSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "sparkle", ofType: "mp3")!))
        }
        catch {
            print(error)
        }
        
        
        getNode = SKSpriteNode(imageNamed: "Get.png")
        readyNode = SKSpriteNode(imageNamed: "Ready.png")
        birdIcon = SKSpriteNode(imageNamed: "BirdIcon.png")
        arrowNode = SKSpriteNode(imageNamed: "Arrow.png")
        handNode = SKSpriteNode(imageNamed: "Hand.png")
        tapNode = SKSpriteNode(imageNamed: "Tap.png")
        
        
        getNode.position = CGPoint(x: self.frame.width/2 - 100, y: self.frame.height/2 + 200)
        getNode.setScale(3)
        getNode.zPosition = 6
        self.addChild(getNode)
        
        readyNode.position = CGPoint(x: self.frame.width/2 + 50, y: self.frame.height/2 + 200)
        readyNode.setScale(3)
        readyNode.zPosition = 6
        self.addChild(readyNode)
        
        birdIcon.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        birdIcon.setScale(3)
        birdIcon.zPosition = 6
        self.addChild(birdIcon)
        
        arrowNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2 - 50)
        arrowNode.setScale(3)
        arrowNode.zPosition = 6
        self.addChild(arrowNode)
        
        handNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2 - 100)
        handNode.setScale(3)
        handNode.zPosition = 6
        self.addChild(handNode)
        
        tapNode.position = CGPoint(x: self.frame.width/2 + 50, y: self.frame.height/2 - 100)
        tapNode.setScale(3)
        tapNode.zPosition = 6
        self.addChild(tapNode)
        
        getNode.run(SKAction.fadeOut(withDuration: 3))
        readyNode.run(SKAction.fadeOut(withDuration: 3))
        birdIcon.run(SKAction.fadeOut(withDuration: 3))
        arrowNode.run(SKAction.fadeOut(withDuration: 3))
        handNode.run(SKAction.fadeOut(withDuration: 3))
        tapNode.run(SKAction.fadeOut(withDuration: 3))
        
        
        pauseButton = SKSpriteNode(imageNamed: "pauseButton.png")
        pauseButton.zPosition = 6
        pauseButton.setScale(3)
        pauseButton.position = CGPoint(x: self.frame.width/2 - 150, y: self.frame.height/2 + 400)
        self.addChild(pauseButton)
        
        resumeButton = SKSpriteNode(imageNamed: "resumeButton.png")
        resumeButton.zPosition = 6
        resumeButton.setScale(3)
        resumeButton.position = CGPoint(x: self.frame.width/2 - 100, y: self.frame.height/2 + 400)
        self.addChild(resumeButton)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    func addButton() {
        
        gameNode = SKSpriteNode(imageNamed: "Game.png")
        overNode = SKSpriteNode(imageNamed: "Over.png")
        okButton = SKSpriteNode(imageNamed: "okButton.png")
        shareButton = SKSpriteNode(imageNamed: "shareButton.png")
        
        okButton.position = CGPoint(x: self.frame.width/2 - 100, y: self.frame.height/2)
        okButton.setScale(3)
        okButton.zPosition = 6
        self.addChild(okButton)
        
        shareButton.position = CGPoint(x: self.frame.width/2 + 100, y: self.frame.height/2)
        shareButton.setScale(3)
        shareButton.zPosition = 6
        self.addChild(shareButton)
        
        gameNode.position = CGPoint(x: self.frame.width/2 - 100, y: self.frame.height/2 + 100)
        gameNode.setScale(3)
        gameNode.zPosition = 6
        self.addChild(gameNode)
        
        overNode.position = CGPoint(x: self.frame.width/2 + 100, y: self.frame.height/2 + 100)
        overNode.setScale(3)
        overNode.zPosition = 6
        self.addChild(overNode)
        
        
        
        
       
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if(firstBody.categoryBitMask == PhysicsType.score && secondBody.categoryBitMask == PhysicsType.flappybird || firstBody.categoryBitMask == PhysicsType.flappybird && secondBody.categoryBitMask == PhysicsType.score) {
            
            scoreSound.play()
            scoreSound.setVolume(3.0, fadeDuration: 0.5)
            score+=1
            scoreLabel.text = "\(score)"
            
        }
        
        if(firstBody.categoryBitMask == PhysicsType.flappybird && secondBody.categoryBitMask == PhysicsType.ground || firstBody.categoryBitMask == PhysicsType.ground && secondBody.categoryBitMask == PhysicsType.flappybird){
            
            audioPlayer.play()
            death = true
            addButton()
        }
        
        if(firstBody.categoryBitMask == PhysicsType.flappybird && secondBody.categoryBitMask == PhysicsType.pipe || firstBody.categoryBitMask == PhysicsType.pipe && secondBody.categoryBitMask == PhysicsType.flappybird){
            
            audioPlayer.play()
            death = true
            addButton()
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(gameStart) == false {
            
            gameStart = true
            flappyBird.physicsBody?.affectedByGravity = true
            
        
            
            
            let spawn = SKAction.run({
                () in
                
                self.pipes()
            })
            
            let delay = SKAction.wait(forDuration: 2.0)
            let spawnDelay = SKAction.sequence([spawn, delay])
            let spawnDelayForever = SKAction.repeatForever(spawnDelay)
            self.run(spawnDelayForever)
            
            let distance = CGFloat(self.frame.width + pipePair.frame.width)
            let movePipes = SKAction.moveBy(x: -distance - 60, y: 0, duration: TimeInterval(0.008 * distance ))
            let removepipes = SKAction.removeFromParent()
            moveAndRemove = SKAction.sequence([movePipes,removepipes])
            
            flappyBird.physicsBody?.velocity = CGVector(dx: 0,dy: 0)
            flappyBird.physicsBody?.applyImpulse(CGVector(dx: 0,dy: 20))
        }
        else {
            
            if(death == true){
                
            }
            else {
                flappyBird.physicsBody?.velocity = CGVector(dx: 0,dy: 0)
                flappyBird.physicsBody?.applyImpulse(CGVector(dx: 0,dy: 20))
            }
            
            
            
            
            
        }
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if(death == true)
            {
                if(okButton.contains(location)){
                    restartScene()
                }
            }
            
            if(pauseButton.contains(location)){
                isPaused = true
            }
            
            if(resumeButton.contains(location)){
                isPaused = false
            }
        }
        
       
    }
    
    
    func pipes() {
        
        let scoreNode = SKSpriteNode()
        
        scoreNode.size = CGSize(width: 1, height: 137)
        scoreNode.position = CGPoint(x: self.frame.width, y: self.frame.height/2)
        
        scoreNode.physicsBody = SKPhysicsBody(rectangleOf: scoreNode.size)
        scoreNode.physicsBody?.affectedByGravity = false
        scoreNode.physicsBody?.isDynamic = false
        scoreNode.physicsBody?.categoryBitMask = PhysicsType.score
        scoreNode.physicsBody?.collisionBitMask = 0
        scoreNode.physicsBody?.contactTestBitMask = PhysicsType.flappybird
        
        
        
        
        pipePair = SKNode()
        
        let topPipe = SKSpriteNode(imageNamed: "UpPipe.png")
        let bottomPipe = SKSpriteNode(imageNamed: "DownPipe.png")
        
        topPipe.position = CGPoint(x: self.frame.width, y: self.frame.height/2 + 200)
        bottomPipe.position = CGPoint(x:self.frame.width, y:self.frame.height/2 - 200)
        
        topPipe.setScale(2.0)
        bottomPipe.setScale(2.0)
        
        topPipe.physicsBody = SKPhysicsBody(rectangleOf: topPipe.size)
        topPipe.physicsBody?.categoryBitMask = PhysicsType.pipe
        topPipe.physicsBody?.collisionBitMask = PhysicsType.flappybird
        topPipe.physicsBody?.contactTestBitMask = PhysicsType.flappybird
        topPipe.physicsBody?.isDynamic = false
        topPipe.physicsBody?.affectedByGravity = false
        
        bottomPipe.physicsBody = SKPhysicsBody(rectangleOf: bottomPipe.size)
        bottomPipe.physicsBody?.categoryBitMask = PhysicsType.pipe
        bottomPipe.physicsBody?.collisionBitMask = PhysicsType.flappybird
        bottomPipe.physicsBody?.contactTestBitMask = PhysicsType.flappybird
        bottomPipe.physicsBody?.isDynamic = false
        bottomPipe.physicsBody?.affectedByGravity = false
        
        
        
        pipePair.addChild(topPipe)
        pipePair.addChild(bottomPipe)
        
        pipePair.addChild(scoreNode)
        
        pipePair.run(moveAndRemove)
        pipePair.zPosition = 1
        self.addChild(pipePair)
    }
    
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
}
