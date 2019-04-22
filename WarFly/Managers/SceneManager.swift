//
//  SceneManager.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 22/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit

//337. Нужен для того чтобы держать сильные ссылки на сцены, чтобы они не удалялись и можно было на них вернуться
class SceneManager {
    
    //338. Синглот класса
    static let shared = SceneManager()
    
    var gameScene: GameScene?
}
