//
//  YellowShot.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 21/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit

//233. Наследник для выстрелов
class YellowShot: Shot {
    init() {
        let textureAtlas = Assets.shared.yellowAmmoAtlas //SKTextureAtlas(named: "YellowAmmo")
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
