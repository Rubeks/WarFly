//
//  GameSettings.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 23/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import UIKit

//446. Класс для настройки
class GameSettings: NSObject {

    let ud = UserDefaults.standard
    
    var isMusic = true
    var isSound = true
    
    let musicKey = "music"
    let soundKey = "sound"
    
    override init() {
        super.init()
        
        loadGameSettings()
        
    }
    
    func saveGameSettings() {
        ud.set(isMusic, forKey: musicKey)
        ud.set(isSound, forKey: soundKey)
    }
    
    func loadGameSettings() {
        if ud.value(forKey: musicKey) != nil && ud.value(forKey: soundKey) != nil {
            isMusic = ud.bool(forKey: musicKey)
            isSound = ud.bool(forKey: soundKey)
        }
       
    }
}
