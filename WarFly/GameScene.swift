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
        
        //11.Добавление на экран
        self.addChild(background)
        
        
        
        //30. Для добавления острова ему нужна коорлината. Отрисовка должна происходить на экране. Беру размер экрана
        let screen = UIScreen.main.bounds
        
        //31. Цикл для отрисовки остравов
        for _ in 1...7 {
            
            //32. Рандомное число с верхним диапозоном = ширине экрана, нижнее = 0
            let x: CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
            
            //33. Рандомное число с верхним диапозоном = высоте экрана, нижнее = 0
            let y: CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.height)))

            //34. Добавление острова с рандомными координатами
            let island = Island.populateSprite(at: CGPoint(x: x, y: y))
            self.addChild(island)
            
            //50. Добавление облака над островом.
            let cloud = Cloud.populateSprite(at: CGPoint(x: x, y: y))
            self.addChild(cloud)
        }
        
        
    }
}
