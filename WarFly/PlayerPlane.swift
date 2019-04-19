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
    
    func checkPosition() {
        
        self.position.x += xAcceleration * 50
        
        if self.position.x < -70 {
            self.position.x = screenSize.width + 70
        } else if self.position.x > screenSize.width + 70 {
            self.position.x = -70
        }
    }
    
    func performFly() {
        
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
}
