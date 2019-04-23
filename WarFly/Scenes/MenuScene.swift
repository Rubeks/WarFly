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
class MenuScene: ParentScene {
    
    override func didMove(to view: SKView) {
        
        //306. Проверка свойствао если фолз ( т.е первоначалый запуск приложения то подгружаю атласы текстур)
        /*//240. Подгрузка всех атласов
        Assets.shared.preloadAssets()*/
        if !Assets.shared.isLoaded {
            Assets.shared.preloadAssets()
            Assets.shared.isLoaded = true
        }
        
        //356. Создание заголовка сцены через вызов функции род.класса сцен
        /*//307. Заголовок игры
         let header = SKSpriteNode(imageNamed: "header1")
         header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
         self.addChild(header)*/
        setHeader(with: nil, andBackground: "header1")
       
        
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
            //369. Для возврата при нажате паузы
        else if node.name == "options" {
            
            //370. То осуществляется переход через 1сек, crossFade - плавное растворение
            let transition = SKTransition.crossFade(withDuration: 1.0)
            
            let optionScene = OptionScene(size: self.size)
            
            optionScene.backScene = self
            
            //372. scaleMode такой же как и у GameVC
            optionScene.scaleMode = .aspectFill
            
            //373. Переход при нажатие
            self.scene?.view?.presentScene(optionScene, transition: transition)
        }
        else if node.name == "best" {
            
            //385. То осуществляется переход через 1сек, crossFade - плавное растворение
            let transition = SKTransition.crossFade(withDuration: 1.0)
            
            let bestScene = BestScene(size: self.size)
            
            bestScene.backScene = self
            
            //386. scaleMode такой же как и у GameVC
            bestScene.scaleMode = .aspectFill
            
            //387. Переход при нажатие
            self.scene?.view?.presentScene(bestScene, transition: transition)
        }
    }
}
