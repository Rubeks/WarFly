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
    let initialSize = CGSize(width: 52, height: 52)

    //139. Сохранение в свойстве папки атлас с текстурами
    let textureAtlas = SKTextureAtlas(named: "GreenPowerUp")
    
    //140. Массив который будет заполняться текстурами из атласа
    var animationSpriteArray = [SKTexture]()
    
    //141. Инициализатор для первого спрайта
    init() {
        let greenTexture = textureAtlas.textureNamed("missle_green_01")
        super.init(texture: greenTexture, color: .clear, size: initialSize)
        
        //142. Новое имя этого спрайта
        self.name = "powerUp"
        
        //150. zPosition чтобы самолет мог сталкиваться с плюшками
        self.zPosition = 20
    }
    
    //143. Инициализатор по умолчанию
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //144.
    func performRotation() {
        
        //145. Цикл для заполнения массива названиями текстур
        for i in 1...15 {
            let number = String(format: "%02d", i)
            animationSpriteArray.append(SKTexture(imageNamed: "missle_green_\(number)"))
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


