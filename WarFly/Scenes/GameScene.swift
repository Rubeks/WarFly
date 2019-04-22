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
    private var player: PlayerPlane!
    
    //303. Экземпляр класса интерфейса пользователя
    private let hud = HUD()
    
    private let screenSize = UIScreen.main.bounds.size
   
    override func didMove(to view: SKView) {
        
        //74.
        configureStartScene()
        
        //101. Вызов функций для создания облаков и остравов
        spawnClouds()
        spawnIslands()
        
        //291. Удаляю 157 т.к теперь аласы грузятся на другой сцене
        /*//157. Чтобы не появлялся в момент загрузки белый квадрат вместо самолета
         let deadline = DispatchTime.now() + .nanoseconds(1)
         DispatchQueue.main.asyncAfter(deadline: deadline) { [unowned self] in */
        
        //[unowned self] типо уменьшает массив сильных ссылок
        
        //108.
        self.player.performFly()
        
        //151.1  Создание плюшки с бонусом
        spawnPowerUp()
        
        //176. Создание врагов на экране
        spawnEnemies()
        
        //280. Протокол для регистрации столкновений
        physicsWorld.contactDelegate = self
        
        //281. Отключение гравитации(чтобы самолет не падал вниз экрана)
        physicsWorld.gravity = CGVector.zero
        
        //305. Вызов отрисовки пользователтского UI
        createHUD()
        
    }
    
    //304. Создание интерфейса через объект класса HUD
    private func createHUD() {
        addChild(hud)
        hud.configureUI(screenSize: screenSize)
    }
    
    //172. Метод для создания врага
    private func spawnSpiralOfEnemy() {
        //173. Создание врага
        let enemyTextureAtlas1 = Assets.shared.enemy_1Atlas //SKTextureAtlas(named: "Enemy_1")
        
        //186. Второй атлас для текстур
        let enemyTextureAtlas2 = Assets.shared.enemy_2Atlas //SKTextureAtlas(named: "Enemy_2")
        
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
       
        let spawnAction = SKAction.run {
            let randomNumber = Int(arc4random_uniform(2))
            let powerUp = randomNumber == 1 ? BluePowerUp() : GreenPowerUp()
            
            let randomPositionX = arc4random_uniform(UInt32(self.size.width - 30))
            
            //204. Плюшка рождается на рандомной точке по оси Х и выше экрана на 100 поинтов
            powerUp.position = CGPoint(x: CGFloat(randomPositionX), y: self.size.height + 100)
            
            powerUp.startMovement()
            self.addChild(powerUp)
        }
        
        //205. Время через которое появится новая плюшка
        let randomTimesSpawn = Double(arc4random_uniform(11) + 10)
        
        //206. Задержка
        let waitAction = SKAction.wait(forDuration: randomTimesSpawn)
        
        //207. Отрисовка
        self.run(SKAction.repeatForever(SKAction.sequence([spawnAction, waitAction])))
    }
    
    //72. Физика движения
    override func didSimulatePhysics() {
        
        //107.
        player.checkPosition()
        
        //103. Перебор по нодам которые ушли ниже "у" и их удаление с экрана
        enumerateChildNodes(withName: "sprite") { (node, stop) in
            if node.position.y <= -100 {
                node.removeFromParent()
                
                //208. Проверка удаления плюшки
                //                if node.isKind(of: PowerUp.self) {
                //                    print("PowerUp remove")
                //                }
            }
        }
        
        //231. Удаление с экрана выстрела
        enumerateChildNodes(withName: "shotSprite") { (node, stop) in
            if node.position.y >= self.size.height + 100 {
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
    
    //232. Метод для создания выстрела
    private func playerFire() {
        let shot = YellowShot()
        
        //234. Позиция выстрела совпадает с самолетом
        shot.position = self.player.position
        
        shot.startMovement()
        self.addChild(shot)
    }
    
    //235. Срабатывает при нажатие на экран
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerFire()
    }
}

//283. Расширение для реализации двух методов протокола для столкновений
extension GameScene:  SKPhysicsContactDelegate {
    
    //284. Начало контакта объектов
    func didBegin(_ contact: SKPhysicsContact) {
        
        //290.  Все с @285 до @287 удаляю и делаю через новые битовые маски.
        /*
        //285. Сюда присваиваются сталкивающиеся физические тела
        let bodyA = contact.bodyA.categoryBitMask
        let bodyB = contact.bodyB.categoryBitMask
        
        //286. Маски моих херовин
        let player = BitMaskCategory.player
        let enemy = BitMaskCategory.enemy
        let shot = BitMaskCategory.shot
        let powerUp = BitMaskCategory.powerUp
        
        //287. Проверка на столкновение битовых маск
        if bodyA == player && bodyB == enemy || bodyB == player && bodyA == enemy {
            print("enemy vs player")
        } else if bodyA == player && bodyB == powerUp || bodyB == player && bodyA == powerUp {
            print("powerUp vs player")
        } else if bodyA == shot && bodyB == enemy || bodyB == shot && bodyA == enemy {
            print("enemy vs shot")
        } */
        //291. Определяю контактную котегорию(кто с кем сталкивается)
        let contactCategory: BitMaskCategory = [contact.bodyA.category, contact.bodyB.category]
        switch contactCategory {
        case [.enemy, .player]: print("enemy vs player")
            case [.powerUp, .player]: print("powerUp vs player")
            case [.enemy, .shot]: print("enemy vs shot")
        default:
            preconditionFailure("Не возможно определить категорию столкновения")
        }

    }
    
    //285. Окончание контакта
    func didEnd(_ contact: SKPhysicsContact) {

    }
}
