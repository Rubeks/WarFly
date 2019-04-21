//
//  Assets.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 21/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit

//236. Сингтон который будет подгружать все атласы чтобы не было тормозов
class Assets: SKSpriteNode {

    //237. Экземпляр синглтон
    static let shared = Assets()
    
    //238. Атласы с текстурами
    let yellowAmmoAtlas = SKTextureAtlas(named: "YellowAmmo")
    let playerPlaneAtlas = SKTextureAtlas(named: "PlayerPlane")
    let greenPowerUpAtlas = SKTextureAtlas(named: "GreenPowerUp")
    let bluePowerUpAtlas = SKTextureAtlas(named: "BluePowerUp")
    let enemy_1Atlas = SKTextureAtlas(named: "Enemy_1")
    let enemy_2Atlas = SKTextureAtlas(named: "Enemy_2")

    //239. Подгрузка атласов
    func preloadAssets() {
        yellowAmmoAtlas.preload { print("yellowAmmoAtlas") }
        playerPlaneAtlas.preload { print("playerPlaneAtlas") }
        greenPowerUpAtlas.preload { print("greenPowerUpAtlas") }
        bluePowerUpAtlas.preload { print("bluePowerUpAtlas") }
        enemy_1Atlas.preload { print("enemy_1Atlas") }
        enemy_2Atlas.preload { print("enemy_2Atlas") }

    }
}
