//
//  BitMaskCategory.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 21/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import Foundation


//254. Структура для создания битовых масок,херни для столкновений между объектами
struct BitMaskCategory {
    static let player: UInt32 = 0x1 << 0    //31 ноль и в конце 1
    static let enemy: UInt32 = 0x1 << 1     //30 нулей и в конце 10
    static let powerUp: UInt32 = 0x1 << 2   //29 нулей и в конце 100
    static let shot: UInt32 = 0x1 << 3      //28 нулей и в конце 1000
}
