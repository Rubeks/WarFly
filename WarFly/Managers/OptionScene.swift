//
//  OptionScene.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 22/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit

//358. Сцена с настройками
class OptionScene: ParentScene {
    
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        
        //359. Заголовок сцены
        setHeader(with: "options", andBackground: "header_background")
        
        //360. Кнопки
        let buttonMusic = ButtonNode(titled: nil, backgroundName: "music")
        buttonMusic.position = CGPoint(x: self.frame.midX - 50, y: self.frame.midY)
        buttonMusic.name = "music"      //нужно имя для того чтобы сработал метод touchesBegan
        buttonMusic.lable.isHidden = true
        addChild(buttonMusic)
        
        let buttonSound = ButtonNode(titled: nil, backgroundName: "sound")
        buttonSound.position = CGPoint(x: self.frame.midX + 50, y: self.frame.midY)
        buttonSound.name = "sound"      //нужно имя для того чтобы сработал метод touchesBegan
        buttonSound.lable.isHidden = true
        addChild(buttonSound)
        
        let backButton = ButtonNode(titled: "back", backgroundName: "button_background")
        backButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        backButton.name = "back"      //нужно имя для того чтобы сработал метод touchesBegan
        backButton.lable.name = "back"
        addChild(backButton)
        
        
    }
    
    //361. Срабатывает при нажатие
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //362. Координаты куда нажал пальцем, self - сцена эта
        let location = touches.first?.location(in: self)
        
        //363. Объект который находится под той точкой куда нажал пальцем
        let node = self.atPoint(location!)
        
        //364. Если под пальцем находится моя кнопка(проверка по имени)
        if node.name == "music" {
            
            
        } else if node.name == "sound" {
            
        } else if node.name == "back" {
            
            
            //365. То осуществляется переход через 1сек, crossFade - плавное растворение
            let transition = SKTransition.crossFade(withDuration: 1.0)
            
            guard let backScene = backScene else { return }
            
            //366. scaleMode такой же как и у GameVC
            backScene.scaleMode = .aspectFill
            
            //367. Переход при нажатие
            self.scene?.view?.presentScene(backScene, transition: transition)
        }
    }
    
    
    
}
