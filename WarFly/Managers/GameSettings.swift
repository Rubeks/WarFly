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
    
    //457. Для хранения результатов
    var highscore: [Int] = []
    
    let musicKey = "music"
    let soundKey = "sound"
    
    let highscoreKey = "highscore"
    
    //458. Сохранение результата при геймовере
    var currentScore = 0
    
    override init() {
        super.init()
        loadGameSettings()
        loadScores()
    }
    
    //--------------------
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
    
    //--------------------
    func saveScores() {
        highscore.append(currentScore)
        highscore = Array(highscore.sorted { $0 > $1 }.prefix(3))
        ud.set(highscore, forKey: highscoreKey)
        ud.synchronize()
    }
    
    func loadScores() {
        guard ud.value(forKey: highscoreKey) != nil else { return }
        highscore = ud.array(forKey: highscoreKey) as! [Int]
    }
}
