//
//  Enemy.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 21/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit

//158. Класс для создания врага
class Enemy: SKSpriteNode {

    //159. Свойство для хранения массива структур вражеского самолета
    static var textureAtlas: SKTextureAtlas?
    
    //177. Свойство для хранения текстур
    var enemyTexture: SKTexture!
    
    //160. Дефолтный инициализатор для объекта класаа
    init(enemyTexture: SKTexture) {
        
        //161. Свойство с текстурой вражеского самолета
        let texture = enemyTexture
        
        super.init(texture: texture, color: .clear, size: CGSize(width: 221, height: 204))
        
        //162. Масштаб по х
        self.xScale = 0.5
        
        //163. Масштаб по У - т.к самолет врага должен быть направлен в противоположную сторону
        self.yScale = -0.5
        
        //164. На одном уровне с пользователем
        self.zPosition = 20
        
        //165. Имя текстуры чтобы можно было удалять самолеты улетевшие за экран
        self.name = "sprite"
        
        //259. Создание физического тела объекта врага
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
        
        //260. Т.е если что-то врезается в самолет он будет двигаться
        self.physicsBody?.isDynamic = true
        
        self.physicsBody?.categoryBitMask = BitMaskCategory.enemy
        
        //261. С чем может взаимодействовать(самолет юзера и пули)
        self.physicsBody?.collisionBitMask = BitMaskCategory.player | BitMaskCategory.shot
        
        //262. Регистрация столкновений с самолетом юзера и пуль
        self.physicsBody?.contactTestBitMask = BitMaskCategory.player | BitMaskCategory.shot
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //167.Метод для движения самолета по спирали
    func flySpiral() {
        let timeHorizontal: Double = 3
        let timeVertical: Double = 6
        
        let screenSize = UIScreen.main.bounds
    
        //168. Враг должен двигаться влево по ширине экрана не долетая 50 поинтов до конца т.к ширина спрайта 221 я взял у него мастаб 0.5 т,е он стал 110 поинтов и я его ограничиваю в 50 до конца, значит краем крыла он сможет залетать за границу экрана.
        //169. Движение влево и вправо
        let moveLeft = SKAction.moveTo(x: 50, duration: timeHorizontal)
        moveLeft.timingMode = .easeInEaseOut    //плавнее будет двигаться
        let moveRight = SKAction.moveTo(x: screenSize.width - 50, duration: timeHorizontal)
        moveRight.timingMode = .easeInEaseOut
        
        //178. Число в диапозоне от 0 до 1
        let randomNumber = Int(arc4random_uniform(2))
        
        //180. Условие на проверку case 0 или 1 и в зависимости от этого меняет направление движения
        let asideMovementSequence = randomNumber == EnemyDirection.left.rawValue ? SKAction.sequence([moveLeft, moveRight]) : SKAction.sequence([moveRight, moveLeft])
        
        let foreverAsideMovement = SKAction.repeatForever(asideMovementSequence)
        
        //170. Движение по вертикали экрана
        let forwardMovement = SKAction.moveTo(y: -105, duration: timeVertical)
        
        //171. Группировка движения по горизонтали и вертикали, получится как по спирали
        let groupMovement = SKAction.group([foreverAsideMovement, forwardMovement])
        
        self.run(groupMovement)
    }
    
    //179.Энум для использования @ 178 чтобы самолеты двигались в разые стороны
    enum EnemyDirection: Int {
        case left = 0
        case right
    }
    
}
