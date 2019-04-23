//
//  ParentScene.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 22/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit

//352.
class ParentScene: SKScene {
    
    //448. Для доступа к настройкам
    let gameSettings = GameSettings()

    //339.
    let sceneManager = SceneManager.shared
    
    //353. Сцена которая была предыдущей
    var backScene: SKScene?
    
    func setHeader(with name: String?, andBackground backgroundName: String) {
        
        //354. Заголовок сцены
        let header = ButtonNode(titled: name, backgroundName: backgroundName)
        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        self.addChild(header)
    }
    
    override init(size: CGSize) {
            super.init(size: size)
       backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
