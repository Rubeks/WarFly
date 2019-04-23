//
//  GameOverScene.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 23/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit

//400. При окончании жизней
class GameOverScene: ParentScene {
    override func didMove(to view: SKView) {
        
        //401. Создание заголовка сцены через вызов функции род.класса сцены
        setHeader(with: "game over", andBackground: "header_background")
        
        //402. Массив заголовков кнопок
        let titles = ["restart", "options", "best"]
        
        //403. Добавление кнопки на экран
        for (index, title) in titles.enumerated() {
            let button = ButtonNode(titled: title, backgroundName: "button_background")
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(100 * index))
            button.name = title       //нужно имя для того чтобы сработал метод touchesBegan
            button.lable.name = title //нужно имя для того чтобы сработал метод touchesBegan
            addChild(button)
        }
    }
    
    //404. Срабатывает при нажатие
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //405. Координаты куда нажал пальцем, self - сцена эта
        let location = touches.first?.location(in: self)
        
        //406. Объект который находится под той точкой куда нажал пальцем
        let node = self.atPoint(location!)
        
        //407. Если под пальцем находится моя кнопка(проверка по имени)
        if node.name == "restart" {
            
            //408. Удаление сцены из менеджера при рестарте
            sceneManager.gameScene = nil
            
            //409. То осуществляется переход через 1сек, crossFade - плавное растворение
            let transition = SKTransition.crossFade(withDuration: 1.0)
            
            //410. Размер сцены с самолетами = сцене с загрузочным экраном
            let gameScene = GameScene(size: self.size)
            
            //411. scaleMode такой же как и у GameVC
            gameScene.scaleMode = .aspectFill
            
            //412. Переход при нажатие
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
            
            //413. Для возврата при нажате паузы
        else if node.name == "best" {
            //414. То осуществляется переход через 1сек, crossFade - плавное растворение
            let transition = SKTransition.crossFade(withDuration: 1.0)
            
            //415.
            let bestScene = BestScene(size: self.size)
            bestScene.backScene = self
            
            //416. scaleMode такой же как и у GameVC
            bestScene.scaleMode = .aspectFill
            
            //417. Переход при нажатие
            self.scene?.view?.presentScene(bestScene, transition: transition)
        }
            //418. Для возврата при нажате паузы
        else if node.name == "options" {
            
            //419. То осуществляется переход через 1сек, crossFade - плавное растворение
            let transition = SKTransition.crossFade(withDuration: 1.0)
            
            let optionScene = OptionScene(size: self.size)
            
            optionScene.backScene = self
            
            //420. scaleMode такой же как и у GameVC
            optionScene.scaleMode = .aspectFill
            
            //421. Переход при нажатие
            self.scene?.view?.presentScene(optionScene, transition: transition)
        }
    }
    
}
