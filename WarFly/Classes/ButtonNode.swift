//
//  ButtonNode.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 22/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit

//308. Класс для реализации кнопки
class ButtonNode: SKSpriteNode {
    
    //309. Создание надписи
    let lable: SKLabelNode = {
        
        //310. Настройка
        let l = SKLabelNode(text: "")
        l.fontColor = UIColor(red: 219 / 255, green: 226 / 255, blue: 215 / 255, alpha: 1.0)
        l.fontName = "AmericanTypewriter-Bold"
        l.fontSize = 25
        l.horizontalAlignmentMode = .center
        l.verticalAlignmentMode = .center
        l.zPosition = 2
        return l
    }()
    
    //311. Иниц в который передаю заголовок и имя изображения для бэкграунда
    init(titled title: String?, backgroundName: String) {
        
        //312. Создаю тектуру из принятого имени
        let texture = SKTexture(imageNamed: backgroundName)
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        if let title = title {
            lable.text = title.uppercased()
        }
        addChild(lable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
