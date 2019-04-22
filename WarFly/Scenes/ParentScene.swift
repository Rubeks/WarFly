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
    
}
