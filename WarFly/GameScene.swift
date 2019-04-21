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
    
    //65.  Создаю плеера
    var player: PlayerPlane!
    
    override func didMove(to view: SKView) {
        
        //74.
        configureStartScene()
        
        //101. Вызов функций для создания облаков и остравов
        spawnClouds()
        spawnIslands()
        
        //157. Чтобы не появлялся в момент загрузки белый квадрат вместо самолета
        let deadline = DispatchTime.now() + .nanoseconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadline) { [unowned self] in
            
            //[unowned self] типо уменьшает массив сильных ссылок
            
            //108.
            self.player.performFly()
        }
        
        //151.1  Создание плюшки с бонусом
        spawnPowerUp()
        
        //176. Создание врагов на экране
        spawnEnemies()
        
        
        
    }
    
    //172. Метод для создания врага
    private func spawnSpiralOfEnemy() {
        //173. Создание врага
        let enemyTextureAtlas1 = SKTextureAtlas(named: "Enemy_1")
        
        //186. Второй атлас для текстур
        let enemyTextureAtlas2 = SKTextureAtlas(named: "Enemy_2")
        
        //подгрузка текстур чтобы не зависало
        SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas1, enemyTextureAtlas2]) { [unowned self] in
            
            //187. Рандомное число
            let randomNumber = Int(arc4random_uniform(2))
            
            //188. Массив из двух атласов
            let arrayOfAtlases = [enemyTextureAtlas1, enemyTextureAtlas2]
            
            //189. Свойство в котором рандомный атлас
            let textureAtlas = arrayOfAtlases[randomNumber]
            
            //174. Задежрка
            let waitAction = SKAction.wait(forDuration: 1.0)
            
            let spawnEnemy = SKAction.run({ [unowned self] in
                
                //191. Отсортировать массив нужно чтобы была картинка самолета центрального
                let textureNames = textureAtlas.textureNames.sorted()
                
                //190. Имя текстуры из двух атласов
                let texture = textureAtlas.textureNamed(textureNames[12])
                
                let enemy = Enemy(enemyTexture: texture)
                enemy.position = CGPoint(x: self.size.width / 2, y: self.size.height + 110)
                self.addChild(enemy)
                enemy.flySpiral()
            })
            
            //175. Создание экшена на появление последовательности врагов
            let spawnAction = SKAction.sequence([waitAction, spawnEnemy])
            let repeatAction = SKAction.repeat(spawnAction, count: 3)
            
            self.run(repeatAction)
        }
    }
    
    //181. Метод который будет вызывать метод  @172
    private func spawnEnemies() {
        
        //182. Задержка
        let waitAction = SKAction.wait(forDuration: 3.0)
        
        //183. Свойство где хранится отрисовки самолетов врага 5 раз
        let spawnSpiralAction = SKAction.run { [unowned self] in
            self.spawnSpiralOfEnemy()
        }
        
        //184. Отрисовка на экране
        self.run(SKAction.repeatForever(SKAction.sequence([waitAction, spawnSpiralAction])))
    }
    
    //151. Метод Создание плюшки с бонусом
    private func spawnPowerUp() {
        let powerUp = BluePowerUp()
        powerUp.performRotation()
        powerUp.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(powerUp)
    }
    
    //72. Физика движения
    override func didSimulatePhysics() {
        
        //107.
        player.checkPosition()
        
        //103. Перебор по нодам которые ушли ниже "у" и их удаление с экрана
        enumerateChildNodes(withName: "sprite") { (node, stop) in
            if node.position.y < -100 {
                node.removeFromParent()
            }
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
        
    }
    
    //91. Функция для генерации бесконечных облаков
    private func spawnClouds() {
        
        //92. Интервал для создания нового облака
        let spawnCloudsWait = SKAction.wait(forDuration: 1)
        
        //93. Создание облака
        let spawnCloudAction = SKAction.run {
            let cloud = Cloud.populate(at: nil)
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
            let island = Island.populate(at: nil)
            self.addChild(island)
        }
        
        //99. Запуск нескольких действий
        let spawnIslandSequence = SKAction.sequence([spawnIslandWait, spawnIslandAction])
        
        //100. повторение экшенов
        let spawnIslandForever = SKAction.repeatForever(spawnIslandSequence)
        
        run(spawnIslandForever)
    }
}
