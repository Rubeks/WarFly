//
//  Shot.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 21/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit

//209. Реализация выстрелов самолета
class Shot: SKSpriteNode {

    //210. Первоначальный размер текстуры
    private let initialSize = CGSize(width: 187, height: 237)
    
    //211. Сохранение в свойстве, папки атлас с текстурами
    private let textureAtlas: SKTextureAtlas!
    
    //212. Массив который будет заполняться текстурами из атласа
    private var animationSpriteArray: [SKTexture] = [SKTexture]()
    
    //213. Свойство для имени текстуры которое будет перебираться из массива атлас текстур
    private var textureNameBeingWith = ""
    
    let screenSize = UIScreen.main.bounds
    
    //214. Инициализатор для спрайта
    init(textureAtlas: SKTextureAtlas) {
        
        //215.
        self.textureAtlas = textureAtlas
        
        //216. Имя первого элемента из атласа
        let textureName = textureAtlas.textureNames.sorted()[0]
        
        //217. Создание текстуры по имени которая принимается как входной параметр в инициализаторе класса
        let texture = textureAtlas.textureNamed(textureName)
        
        //218. Записывается имя текстуры без например 01.png ну или 15.png
        textureNameBeingWith = String(textureName.dropLast(6))
        
        super.init(texture: texture, color: .clear, size: initialSize)
        
        //219. Изменение размера выстрела
        self.setScale(0.25)
        
        //220. Новое имя этого спрайта (пример: для удаления с экрана)
        self.name = "shotSprite"
        
        //221. zPosition чтобы выстрел был под самолетом
        self.zPosition = 30
        
        //267. Создание физического тела объекта врага
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
        
        //268. Т.е если пули будут врезаться во врагом они не будут смещаться
        self.physicsBody?.isDynamic = false
        
        self.physicsBody?.categoryBitMask = BitMaskCategory.shot.rawValue
        
        //269. С чем может взаимодействовать(самолеты врага)
        self.physicsBody?.collisionBitMask = BitMaskCategory.enemy.rawValue
        
        //270. Регистрация столкновений с самолетом врага
        self.physicsBody?.contactTestBitMask = BitMaskCategory.enemy.rawValue
    }
    
    // Инициализатор по умолчанию
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //222. Движение для выстрелов
    func startMovement() {
        
        performRotation()
        
        //223. Верхняя граница куда летит выстрел
        let moveForward = SKAction.moveTo(y: screenSize.height + 100, duration: 2)
        self.run(moveForward)
    }

    //224. Анимация выстрела
    private func performRotation() {
        
        //225. Цикл для заполнения массива названиями текстур
        for i in 1...32 {
            let number = String(format: "%02d", i)
            
            //226.
            animationSpriteArray.append(SKTexture(imageNamed: textureNameBeingWith + number.description))
        }
        
        //227. Подгрузка текстур чтобы не зависало
        SKTexture.preload(animationSpriteArray) {
            
            //228. Свойство где хранится анимированный массив текстур с настройками
            let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.05, resize: true, restore: false)
            
            //229. Бесконечное повторение анимации текстур
            let rotationForever = SKAction.repeatForever(rotation)
            
            //230. Запуск анимации
            self.run(rotationForever)
        }
    }
}
