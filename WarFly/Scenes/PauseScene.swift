//
//  PauseScene.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 22/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit

//315. Класс для сцены с паузой
class PauseScene: ParentScene {

    override func didMove(to view: SKView) {
        
        //355. Создание заголовка сцены через вызов функции род.класса сцены
        /*//316. Заголовок сцены с паузой
        let header = ButtonNode(titled: "pause", backgroundName: "header_background")
        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        self.addChild(header)*/
        setHeader(with: "pause", andBackground: "header_background")
        
        //317. Массив заголовков кнопок
        let titles = ["restart", "options", "resume"]
        
        //318. Добавление кнопки на экран
        for (index, title) in titles.enumerated() {
            let button = ButtonNode(titled: title, backgroundName: "button_background")
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(100 * index))
            button.name = title       //нужно имя для того чтобы сработал метод touchesBegan
            button.lable.name = title //нужно имя для того чтобы сработал метод touchesBegan
            addChild(button)
        }
    }
    
    //319. Срабатывает при нажатие
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //320. Координаты куда нажал пальцем, self - сцена эта
        let location = touches.first?.location(in: self)
        
        //321. Объект который находится под той точкой куда нажал пальцем
        let node = self.atPoint(location!)
        
        //322. Если под пальцем находится моя кнопка(проверка по имени)
        if node.name == "restart" {
            
            //344. Удаление сцены из менеджера при рестарте
            sceneManager.gameScene = nil
            
            //323. То осуществляется переход через 1сек, crossFade - плавное растворение
            let transition = SKTransition.crossFade(withDuration: 1.0)
            
            //324. Размер сцены с самолетами = сцене с загрузочным экраном
            let gameScene = GameScene(size: self.size)
            
            //325. scaleMode такой же как и у GameVC
            gameScene.scaleMode = .aspectFill
            
            //326. Переход при нажатие
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
        
            //332. Для возврата при нажате паузы
        else if node.name == "resume" {
            //333. То осуществляется переход через 1сек, crossFade - плавное растворение
            let transition = SKTransition.crossFade(withDuration: 1.0)
            
            //343.
            guard let gameScene = sceneManager.gameScene else { return }
            
            //335. scaleMode такой же как и у GameVC
            gameScene.scaleMode = .aspectFill
            
            //336. Переход при нажатие
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
    }
    
    //349.
    override func update(_ currentTime: TimeInterval) {
        if let gameScene = sceneManager.gameScene {
            if gameScene.isPaused == false {
                gameScene.isPaused = true
            }
        }
    }
}
