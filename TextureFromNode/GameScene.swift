//
//  GameScene.swift
//  TextureFromNode
//
//  Created by MCC on 3/12/15.
//  Copyright (c) 2015 Tejesh Alimilli. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let longPressGestureRecognizer = UILongPressGestureRecognizer()
    let previewNode = SKSpriteNode()
    let rootNode = SKNode()
    
    override func didMoveToView(view: SKView) {
        addChild(rootNode)
        addChild(previewNode)
        previewNode.size = CGSize(width: 100, height: 100)
        previewNode.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 45;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        rootNode.addChild(myLabel)
        
        let sprite = SKSpriteNode(imageNamed:"Spaceship")
        sprite.xScale = 0.5
        sprite.yScale = 0.5
        sprite.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 150)
        rootNode.addChild(sprite)
        
        longPressGestureRecognizer.addTarget(self, action: "longPressGestureHandler:")
        longPressGestureRecognizer.allowableMovement = CGFloat.max
        view.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func updatePreview(showAt: CGPoint) {
        let rootNodePoint = convertPoint(showAt, toNode: rootNode)
        //
        // the below code doesn't work, use view?.textureFromNode(rootNode) and it works
        //
        if let previewTexture = view?.textureFromNode(rootNode, crop: CGRect(origin: rootNodePoint, size: CGSize(width: 100, height: 100))) {
            previewNode.texture = previewTexture
            previewNode.position = showAt
        }
    }
    
    func longPressGestureHandler(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        var showAt = longPressGestureRecognizer.locationInView(view)
        showAt = convertPointFromView(showAt)
        
        if longPressGestureRecognizer.state == .Began {
            previewNode.hidden = false
            updatePreview(showAt)
        } else if longPressGestureRecognizer.state == .Changed {
            updatePreview(showAt)
        } else {
            previewNode.hidden = true
        }
    }
}
