//
//  GameScene.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 19/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
   
    override func didMove(to view: SKView) {
        
       //9. Буду вызывать фукнцию у класса отечающего за задний фон
        //10.Центр экрана
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = BackGround.populateBackground(at: screenCenterPoint)
        
        //12. Заполнение всего экрана(пример для X XR XS)
        background.size = self.size
        
        //13. Тест гита
        print("haha")
        
        //11.Добавление на экран
        self.addChild(background)
        
    }
}
