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
        
        //306. Проверка свойствао если фолз ( т.е первоначалый запуск приложения то подгружаю атласы текстур)
        /*//240. Подгрузка всех атласов
        Assets.shared.preloadAssets()*/
        if !Assets.shared.isLoaded {
            Assets.shared.preloadAssets()
            Assets.shared.isLoaded = true
        }
        
        self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        
        //307. Заголовок игры
        let header = SKSpriteNode(imageNamed: "header1")
        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        self.addChild(header)
        
        //313. Массив заголовков кнопок
        let titles = ["play", "options", "best"]
        
        //314. Добавление кнопки на экран
        for (index, title) in titles.enumerated() {
            let button = ButtonNode(titled: title, backgroundName: "button_background")
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(100 * index))
            button.name = title       //нужно имя для того чтобы сработал метод touchesBegan
            button.lable.name = title //нужно имя для того чтобы сработал метод touchesBegan
            addChild(button)
        }   
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //246. Координаты куда нажал пальцем, self - сцена эта
        let location = touches.first?.location(in: self)
        
        //247. Объект который находится под той точкой куда нажал пальцем
        let node = self.atPoint(location!)
        
        //248. Если под пальцем находится моя кнопка(проверка по имени)
        if node.name == "play" {
            
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
