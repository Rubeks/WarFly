//
//  BitMaskCategory.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 21/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit


//288. Изменение битово маски чтобы была типо супер универсальной
/*//254. Структура для создания битовых масок,херни для столкновений между объектами
struct BitMaskCategory: OptionSet {
    static let player: UInt32 = 0x1 << 0    //31 ноль и в конце 1
    static let enemy: UInt32 = 0x1 << 1     //30 нулей и в конце 10
    static let powerUp: UInt32 = 0x1 << 2   //29 нулей и в конце 100
    static let shot: UInt32 = 0x1 << 3      //28 нулей и в конце 1000
}*/
struct BitMaskCategory: OptionSet {
    
    let rawValue: UInt32
    
    static let none    = BitMaskCategory(rawValue: 0 << 0)      //32 нуля                   0
    static let player  = BitMaskCategory(rawValue: 1 << 0)      //31 ноль и в конце 1       1
    static let enemy   = BitMaskCategory(rawValue: 1 << 1)      //30 нулей и в конце 10     2
    static let powerUp = BitMaskCategory(rawValue: 1 << 2)      //29 нулей и в конце 100    4
    static let shot    = BitMaskCategory(rawValue: 1 << 3)      //28 нулей и в конце 1000   8
    static let all     = BitMaskCategory(rawValue: UInt32.max)
}

//289. Расширение
extension SKPhysicsBody {
    var category: BitMaskCategory {
        get {
            return BitMaskCategory(rawValue: self.categoryBitMask)
        }
        
        set {
            self.categoryBitMask = newValue.rawValue
        }
    }
}
