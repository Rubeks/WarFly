//
//  MenuScene.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 21/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit
import GameplayKit

//243. Стартовая сцена
class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        //240. Подгрузка всех атласов
        Assets.shared.preloadAssets()
        
        self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        
        //244. Текстура кнопки
        let texture = SKTexture(imageNamed: "play")
        let button = SKSpriteNode(texture: texture)
        
        //245. Координата кнопки в центре экрана
        button.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        button.name = "runButton"
        self.addChild(button)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //246. Координаты куда нажал пальцем, self - сцена эта
        let location = touches.first?.location(in: self)
        
        //247. Объект который находится под той точкой куда нажал пальцем
        let node = self.atPoint(location!)
        
        //248. Если под пальцем находится моя кнопка(проверка по имени)
        if node.name == "runButton" {
            
            //249. То осуществляется переход через 1сек, crossFade - плавное растворение
            let transition = SKTransition.crossFade(withDuration: 1.0)
            
            //250. Размер сцены с самолетами = сцене с загрузочным экраном
            let gameScene = GameScene(size: self.size)
            
            //251. scaleMode такой же как и у GameVC
            gameScene.scaleMode = .aspectFill
            
            //252. Переход при нажатие
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
    }
}
