//
//  PlayerPlane.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 19/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit

//62. Класс для самолета игрока
class PlayerPlane: SKSpriteNode {

    static func populate(at point: CGPoint) -> SKSpriteNode {
        
        //63. Текстура самолета
        let playerPlaneTexture = SKTexture(imageNamed: "airplane_3ver2_13")
        
        //63. Спрайт самолета по текстуре
        let playerPlane = SKSpriteNode(texture: playerPlaneTexture)
        
        //64. Масштаб самолета
        playerPlane.setScale(0.5)
        playerPlane.position = point
        playerPlane.zPosition = 20
        
        return playerPlane
    }
}
