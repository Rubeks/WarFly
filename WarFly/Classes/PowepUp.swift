//
//  PowepUp.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 21/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit

//137. Класс для реализации мощи самолета, типо подбор плюшек для его усиления
class PowerUp: SKSpriteNode {
    
    //138. Первоначальный размер текстуры
    private let initialSize = CGSize(width: 52, height: 52)
    
    //192. Делаю из этого класса супер класс для двух наследников
    /*//139. Сохранение в свойстве папки атлас с текстурами
     //let textureAtlas = SKTextureAtlas(named: "GreenPowerUp")*/
    private let textureAtlas: SKTextureAtlas!
    
    //140. Массив который будет заполняться текстурами из атласа
    private var animationSpriteArray = [SKTexture]()
    
    //196. Свойство для имени текстуры которое будет рандомное
    private var textureNameBeingWith = ""
    
    //141. Инициализатор для первого спрайта
    init(textureAtlas: SKTextureAtlas) {
        
        //193.
        self.textureAtlas = textureAtlas
        
        //194. Имя первого элемента из атласа
        let textureName = textureAtlas.textureNames.sorted()[0]
        
        //195. Создание текстуры по имени которая принимается как входной параметр в инициализаторе класса
        let texture = textureAtlas.textureNamed(textureName)
        
        //196. Записывается имя текстуры без например 01.png ну или 15.png
        textureNameBeingWith = String(textureName.dropLast(6))
        
        super.init(texture: texture, color: .clear, size: initialSize)
        
        //199. Изменение размера плюшки
        self.setScale(0.6)
        
        //142. Новое имя этого спрайта
        self.name = "sprite"
        
        //150. zPosition чтобы самолет мог сталкиваться с плюшками
        self.zPosition = 20
        
        //263. Создание физического тела объекта врага
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
        
        //264. Т.е если что-то врезается в плюшку он будет двигаться или чтото с ним будет происходить
        self.physicsBody?.isDynamic = true
        
        self.physicsBody?.categoryBitMask = BitMaskCategory.powerUp.rawValue
        
        //265. С чем может взаимодействовать(самолет юзера)
        self.physicsBody?.collisionBitMask = BitMaskCategory.player.rawValue
        
        //266. Регистрация столкновений с самолетом юзера
        self.physicsBody?.contactTestBitMask = BitMaskCategory.player.rawValue
        
    }
    
    //143. Инициализатор по умолчанию
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //202. Движение для плюшек
    func startMovement() {
        
        performRotation()
        
        //203. Смещение плюшки
        let moveForward = SKAction.moveTo(y: -100, duration: 5)
        self.run(moveForward)
    }
    
    
    //144. Анимация вращения плюшки
    private func performRotation() {
        
        //197. Меняю цикл чтобы добавлялась текстура в массив с полным именем
        //145. Цикл для заполнения массива названиями текстур
        for i in 1...15 {
            let number = String(format: "%02d", i)
            //animationSpriteArray.append(SKTexture(imageNamed: "missle_green_\(number)"))
            //198.
            animationSpriteArray.append(SKTexture(imageNamed: textureNameBeingWith + number.description))
            
        }
        
        //146. Подгрузка текстур чтобы не зависало
        SKTexture.preload(animationSpriteArray) {
            
            //147. Свойство где хранится анимированный массив текстур с настройками
            let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.05, resize: true, restore: false)
            
            //148. Бесконечное повторение анимации текстур
            let rotationForever = SKAction.repeatForever(rotation)
            
            //149. Запуск анимации
            self.run(rotationForever)
        }
    } 
}


