//
//  MenuScene.swift
//  SuperSpaceMan
//
//  Created by Apptist Inc on 2019-03-11.
//  Copyright © 2019 Mark Meritt. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MenuScene: SKScene, SKPhysicsContactDelegate  {
    
    //TODO: - Use this to create a menu scene
    
    //TODO: - Add a main menu and play button
    
    
    var background = SKSpriteNode()
    var ground = SKSpriteNode()
    var flappyNode = SKSpriteNode()
    var birdNode = SKSpriteNode()
    var Bird = SKSpriteNode()
    var TextureAtlas = SKTextureAtlas()
    var TextureArray = [SKTexture]()
    
    var scoreButton = SKSpriteNode()
    var startButton = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        
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
       
        
        flappyNode = SKSpriteNode(imageNamed: "Flappy.png")
        birdNode = SKSpriteNode(imageNamed: "Bird.png")
        
        
        flappyNode.position = CGPoint(x: self.frame.width/2 - 100, y: self.frame.height/2 + 200)
        flappyNode.setScale(3)
        flappyNode.zPosition = 6
        self.addChild(flappyNode)
        
        birdNode.position = CGPoint(x: self.frame.width/2 + 50, y: self.frame.height/2 + 200)
        birdNode.setScale(3)
        birdNode.zPosition = 6
        self.addChild(birdNode)
        
        
        
        TextureAtlas = SKTextureAtlas(named: "flappybird")
        for i in 1...3{
            
            let Name = "flappybird_\(i)"
            TextureArray.append(SKTexture(imageNamed: Name))
            
        }
        
        
        Bird = SKSpriteNode(imageNamed: "flappybird_1" )
        Bird.setScale(3)
        Bird.position = CGPoint(x:self.frame.width/2 + 150, y: self.frame.height/2 + 200)
        Bird.zPosition = 6
        Bird.run(SKAction.repeatForever(SKAction.animate(with: TextureArray, timePerFrame: 0.1, resize: true, restore: true)))
        self.addChild(Bird)
        
        
        
        startButton = SKSpriteNode(imageNamed: "Start.png")
        scoreButton = SKSpriteNode(imageNamed: "Score.png")
        
        startButton.position = CGPoint(x: self.frame.width/2 - 100, y: self.frame.height/2 - 250)
        startButton.setScale(3)
        startButton.zPosition = 6
        self.addChild(startButton)
        
        scoreButton.position = CGPoint(x: self.frame.width/2 + 100, y: self.frame.height/2 - 250)
        scoreButton.setScale(3)
        scoreButton.zPosition = 6
        self.addChild(scoreButton)
        
        
        
    }
    
    
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            //TODO: - Create a transition
            
            let location = touch.location(in: self)
            
            
            
            if(startButton.contains(location)){
                
                scene?.view?.presentScene(GameScene(size: self.frame.size))
            }
        }
    }
}
