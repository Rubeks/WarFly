//
//  HUD.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 22/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit

//302. Интерфейс пользователя UI
class HUD: SKScene {
    
    //293. Свойство для бэкграунда для лэйбла
    let scoreBackground = SKSpriteNode(imageNamed: "scores")
    
    //294. Лэйбл с очками
    let scoreLabel = SKLabelNode(text: "1000")
    
    //295. кнопка меню
    let menuButton = SKSpriteNode(imageNamed: "menu")
    
    //296. Жизни игрока
    let life1 = SKSpriteNode(imageNamed: "life")
    let life2 = SKSpriteNode(imageNamed: "life")
    let life3 = SKSpriteNode(imageNamed: "life")
    
    //292. Настройка UI ( добавление жизней и лейбла с очками)
    func configureUI(screenSize: CGSize) {
        
        //-------------- Задник под очки
        //297. Центр текстуры т.е сейчас он справа в центре по вертикали
        scoreBackground.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        
        //298. Положение задника ( левый верхний угол с отступом в 10)
        scoreBackground.position = CGPoint(x: scoreBackground.frame.width + 10, y: screenSize.height - scoreBackground.frame.height / 2 - 10)
        
        scoreBackground.zPosition = 99
        addChild(scoreBackground)
        
        //299. -------------- Лэйбл с очками
        scoreLabel.horizontalAlignmentMode = .right     //выравнивание
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.position = CGPoint(x: -10, y: 3)     //позиция относительно родителя будет
        scoreLabel.zPosition = 100                      //высота слоя
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 30
        scoreBackground.addChild(scoreLabel)
        
        //300. -------------- Кнопка меню
        menuButton.anchorPoint = CGPoint(x: 0.0, y: 0.0)    //центр кнопки будет в левом нижнем углу
        menuButton.position = CGPoint(x: 20, y: 20)
        menuButton.zPosition = 100
        addChild(menuButton)
        
        //301. -------------- Жизни игрока
        let lifes = [life1, life2, life3]
        for (index, life) in lifes.enumerated() {
            life.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            life.position = CGPoint(x: screenSize.width - CGFloat(index + 1) * (life.size.width + 3), y: 20)
            life.zPosition = 100
            
            addChild(life)
        }
    }
}
