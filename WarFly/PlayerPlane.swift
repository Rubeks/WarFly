//
//  PlayerPlane.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 19/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit

//67. Для доступа к акселерометру
import CoreMotion

//62. Класс для самолета игрока
class PlayerPlane: SKSpriteNode {
    
    //68. Объект для работы с наклоном телефона
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0.0
    
    //109. Массивы в котором будут картинки самолета с поворотом влево
    var leftTextureArrayAnimation = [SKTexture]()
    var rightTextureArrayAnimation = [SKTexture]()
    var forwardTextureArrayAnimation = [SKTexture]()
    
    //124. свойство для метода @122
    var moveDirection: TurnDirection = .none
    
    //125. Чтобы анимация не прерывала себя(пример поворачиваю влево и резко стал поворачивать вправо)
    var stillTurning = false
    
    
    //108.
    let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
    static func populate(at point: CGPoint) -> PlayerPlane {
        
        //63. Текстура самолета
        let playerPlaneTexture = SKTexture(imageNamed: "airplane_3ver2_13")
        
        //63. Спрайт самолета по текстуре
        let playerPlane = PlayerPlane(texture: playerPlaneTexture)
        
        //64. Масштаб самолета
        playerPlane.setScale(0.5)
        playerPlane.position = point
        playerPlane.zPosition = 20
        
        return playerPlane
    }
    
    //106.1 Проверка позиции самолета. Если упирается в край экрана то появляется слева
    func checkPosition() {
        
        self.position.x += xAcceleration * 50
        
        if self.position.x < -70 {
            self.position.x = screenSize.width + 70
        } else if self.position.x > screenSize.width + 70 {
            self.position.x = -70
        }
    }
    
    //106.2 Движение самолета в зависимости от акселерометра
    func performFly() {
        
        //121. Перед началом полета подгружаю эти картинки
        planeAnimationFillArray()
        
        //69. Как часто замерять ускорение
        motionManager.accelerometerUpdateInterval = 0.2
        
        //70. OperationQueue.current будет работать в паралельном потоке
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { [unowned self] (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                
                //71. Данные о ускорении по оси х
                self.xAcceleration = CGFloat(acceleration.x) * 0.25 + self.xAcceleration * 0.1
            }
        }
        
        //136.
        let planeWhaitAction = SKAction.wait(forDuration: 1.0)
        let planeDirectionCheckAction = SKAction.run { [unowned self] in
            self.movementDirectionsCheck()
        }
        
        let planeSequence = SKAction.sequence([planeWhaitAction, planeDirectionCheckAction])
        let planeSequenceForever = SKAction.repeatForever(planeSequence)
        self.run(planeSequenceForever)
        
    }
    
    //110. Метод для перебора изображений и сохранение в массив
    private func planeAnimationFillArray() {
        SKTextureAtlas.preloadTextureAtlases([SKTextureAtlas(named: "PlayerPlane")]) {
            
            //110.1 Заполнение левого массива
            self.leftTextureArrayAnimation = {
                
                //111. Создаю пустой массив
                var array = [SKTexture]()
                
                //112. Перебираю все изображения от 13 до 1
                for i in stride(from: 13, through: 1, by: -1) {
                    
                    //113ю ХЗ что это...типо создает строку с нажванием от 13 до 1
                    let number = String(format: "%02d", i)
                    
                    //114. Создает имя файла текстуры с разными параметрами в конце от 1 до 13
                    let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
                    
                    //115. Добавление в массив текстуры
                    array.append(texture)
                }
                
                SKTexture.preload(array, withCompletionHandler: {
                    print("preload is done")
                })
                return array
            }()
            
            //116. Заполнение правого массива
            self.rightTextureArrayAnimation = {
                
                //117. Создаю пустой массив
                var array = [SKTexture]()
                
                //118. Перебираю все изображения от 13 до 26
                for i in stride(from: 13, through: 26, by: 1) {
                    
                    //119. ХЗ что это...типо создает строку с нажванием от 13 до 26
                    let number = String(format: "%02d", i)
                    
                    //120. Создает имя файла текстуры с разными параметрами в конце от 13 до 26
                    let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
                    
                    //121. Добавление в массив текстуры
                    array.append(texture)
                }
                
                SKTexture.preload(array, withCompletionHandler: {
                    print("preload is done")
                })
                return array
            }()
            
            //117.
            self.forwardTextureArrayAnimation = {
                
                //118. Создаю пустой массив
                var array = [SKTexture]()
                
                //119. Создает имя файла текстуры с 13
                let texture = SKTexture(imageNamed: "airplane_3ver2_13")
                    
                //120. Добавление в массив текстуры
                array.append(texture)
                
                SKTexture.preload(array, withCompletionHandler: {
                    print("preload is done")
                })
                return array
            }()
        }
    }
    
    //122. Метод который будет следить за значением акселерерометра, если поворот влево то он - ,если вправо то +
    private func movementDirectionsCheck() {
        
        if xAcceleration > 0.01, moveDirection != .right, stillTurning == false {
            stillTurning = true
            moveDirection = .right
            
            //133.
            turnPlane(direction: .right)
            
        } else if xAcceleration < -0.01, moveDirection != .left, stillTurning == false {
            stillTurning = true
            moveDirection = .left
            
            //134.
            turnPlane(direction: .left)
        } else if stillTurning == false {
            
            //135.
            turnPlane(direction: .none)
        }
    }
    
    //126.Метод который будет вызываться для каждого конкретного поворота
    private func turnPlane(direction: TurnDirection) {
        
        //127
        var array = [SKTexture]()
        
        //128. Заполнение массива в зависимости от поворота
        if direction == .right {
            array = rightTextureArrayAnimation
        } else if direction == .left {
            array = leftTextureArrayAnimation
        } else {
            array = forwardTextureArrayAnimation
        }
        
        //129. Т.к анимация должна проигрываться 2 раза т.е происходит поворот влево это картинки от 13 до 1, при повороте вправо должно отобразится от 1 до 13 и дальше от 13 до 26. Сделаю 2 экшена.
        let forwardAction = SKAction.animate(with: array, timePerFrame: 0.05, resize: true, restore: false)
        //restore - возврат в исходную позицию; timePerFrame - время на кадр
        
        //130.
        let backwardAction = SKAction.animate(withNormalTextures: array.reversed(), timePerFrame: 0.05, resize: true, restore: false)
        
        //131. Последовательность анимаций
        let sequenceAction = SKAction.sequence([forwardAction, backwardAction])
        
        //132. Вызов анимации
        self.run(sequenceAction) { [unowned self] in
            self.stillTurning = false
        }
    }
    
    //123. enum для поворотов
    enum TurnDirection {
        case left
        case right
        case none
    }
    
    
}
