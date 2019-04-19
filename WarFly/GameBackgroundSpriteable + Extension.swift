//
//  GameBackgroundSpriteable + Extension.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 19/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit
import GameplayKit

//36. Т.к и остров и облако используют один и тоже код нужно для них сделать протокол
protocol GameBackgroundSpriteable {
    static func populate(at point: CGPoint?) -> Self
    static func randomPoint() -> CGPoint
}

//75. Расширение для протокола
extension GameBackgroundSpriteable {
    static func randomPoint() -> CGPoint {
        
        //76. Размер экрана
        let screen = UIScreen.main.bounds
        
        //77. Точка выше экрана по у
        let distribution = GKRandomDistribution(lowestValue: Int(screen.size.height) + 400, highestValue: Int(screen.size.height) + 500)
        
        //78. Рандомное число в диапазоне от высоты экрана +100 и +200
        let y = CGFloat(distribution.nextInt())
        
        //79. Рандомное число от 0 до ширины экрана
        let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
        
        return CGPoint(x: x, y: y)
    }
}
