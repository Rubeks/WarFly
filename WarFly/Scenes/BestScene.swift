//
//  BestScene.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 23/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit

//374. Сцена с очками
class BestScene: ParentScene {
    
    //375. Массив с очками
    var places = [10, 100, 10000]

    override func didMove(to view: SKView) {
        
        //376. Заголовок сцены
        setHeader(with: "best", andBackground: "header_background")
        
        //377. Массив заголовков кнопок
        let titles = ["back"]
        
        //378. Добавление кнопки на экран
        for (index, title) in titles.enumerated() {
            let button = ButtonNode(titled: title, backgroundName: "button_background")
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 200 + CGFloat(100 * index))
            button.name = title       //нужно имя для того чтобы сработал метод touchesBegan
            button.lable.name = title //нужно имя для того чтобы сработал метод touchesBegan
            addChild(button)
        }
        
        let topPlaces = places.sorted { $0 > $1 }.prefix(3) //$0 > $1 элемент сева должен быть больше элемента справа, prefix - обрезка элементов до 3
        
        //379. Создание надписи
        for (index, value) in topPlaces.enumerated() {
            
            //380. Настройка
            let l = SKLabelNode(text: value.description)
            l.fontColor = UIColor(red: 219 / 255, green: 226 / 255, blue: 215 / 255, alpha: 1.0)
            l.fontName = "AmericanTypewriter-Bold"
            l.fontSize = 25
            l.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(index * 60))
            addChild(l)
        }
    }
    
    //381. Срабатывает при нажатие
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //382. Координаты куда нажал пальцем, self - сцена эта
        let location = touches.first?.location(in: self)
        
        //383. Объект который находится под той точкой куда нажал пальцем
        let node = self.atPoint(location!)
        
        //384. Если под пальцем находится моя кнопка(проверка по имени)
        if node.name == "back" {
            
            
            //365. То осуществляется переход через 1сек, crossFade - плавное растворение
            let transition = SKTransition.crossFade(withDuration: 1.0)
            
            guard let backScene = backScene else { return }
            
            //388. scaleMode такой же как и у GameVC
            backScene.scaleMode = .aspectFill
            
            //389. Переход при нажатие
            self.scene?.view?.presentScene(backScene, transition: transition)
        }
    }
    
    
}
