//
//  BackGround.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 19/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit

//4. Класс который будет настраивать задний фон
class BackGround: SKSpriteNode {

    //5. Функция класса
    static func populateBackground(at point: CGPoint) -> BackGround {
        
        //6. Создает фон по названию изображения
        let background = BackGround(imageNamed: "background")
       
        //7. Координата для отрисовки, берет значение из принимаего функцией
        background.position = point
        
        //8. Будет самым нижнем слоем.
        background.zPosition = 0
        
        return background
    }
    
}
