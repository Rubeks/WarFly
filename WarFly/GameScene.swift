//
//  GameScene.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 19/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit
import GameplayKit

//67. Для доступа к акселерометру
import CoreMotion

class GameScene: SKScene {
    
    //65.  Создаю плеера
    var player: SKSpriteNode!
    
    //68. Объект для работы с наклоном телефона
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0.0
   
    override func didMove(to view: SKView) {
        
        //74.
        configureStartScene()
        
        //101. Вызов функций для создания облаков и остравов
        spawnClouds()
        spawnIslands()
       
    }
    
    //72. Физика движения
    override func didSimulatePhysics() {
        
        player.position.x += xAcceleration * 50
        
        if player.position.x < -70 {
            player.position.x = self.size.width + 70
        } else if player.position.x > self.size.width + 70 {
            player.position.x = -70
        }
    }
    
    //73. Переношу все из didMove в новый метод
    private func configureStartScene() {
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
        
        //80. Удаляю цикл для отрисовки и задаю сам первоначальное положение
        //31. Цикл для отрисовки остравов
        /*for _ in 1...7 {
            
            //32. Рандомное число с верхним диапозоном = ширине экрана, нижнее = 0
            let x: CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
            
            //33. Рандомное число с верхним диапозоном = высоте экрана, нижнее = 0
            let y: CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.height)))
        }
 */
        //81. Добавление острова с рандомными координатами
        let island1 = Island.populate(at: CGPoint(x: 100, y: 200))
        self.addChild(island1)

        //82. второй остров
        let island2 = Island.populate(at: CGPoint(x: self.size.width - 100, y: self.size.height - 200))
        self.addChild(island2)
        
        //66. Добавление самолета
        player = PlayerPlane.populate(at: CGPoint(x: screen.size.width / 2, y: 100))
        self.addChild(player)
        
        //69. Как часто замерять ускорение
        motionManager.accelerometerUpdateInterval = 0.2
        
        //70. OperationQueue.current будет работать в паралельном потоке
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                
                //71. Данные о ускорении по оси х
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
            }
        }
    }
    
    //91. Функция для генерации бесконечных облаков
    private func spawnClouds() {
        
        //92. Интервал для создания нового облака
        let spawnCloudsWait = SKAction.wait(forDuration: 1)
        
        //93. Создание облака
        let spawnCloudAction = SKAction.run {
            let cloud = Cloud.populate()
            self.addChild(cloud)
        }
        
        //94. Запуск нескольких действий
        let spawnCloudSequence = SKAction.sequence([spawnCloudsWait, spawnCloudAction])
        
        //95. повторение экшенов
        let spawnCloudForever = SKAction.repeatForever(spawnCloudSequence)
        
        run(spawnCloudForever)
    }
    
    //96. Функция для генерации бесконечных остравов
    private func spawnIslands() {
        
        //97. Интервал для создания нового облака
        let spawnIslandWait = SKAction.wait(forDuration: 1)
        
        //98. Создание облака
        let spawnIslandAction = SKAction.run {
            let island = Island.populate()
            self.addChild(island)
        }
        
        //99. Запуск нескольких действий
        let spawnIslandSequence = SKAction.sequence([spawnIslandWait, spawnIslandAction])
        
        //100. повторение экшенов
        let spawnIslandForever = SKAction.repeatForever(spawnIslandSequence)
        
        run(spawnIslandForever)
    }
}
