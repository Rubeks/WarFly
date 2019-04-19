//
//  Cloud.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 19/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit
import GameplayKit

//36. Т.к и остров и облако используют один и тоже код нужно для них сделать протокол
protocol GameBackgroundSpriteable {
    static func populateSprite(at point: CGPoint) -> Self
}

//35. Класс для Облаков
final class Cloud: SKSpriteNode, GameBackgroundSpriteable {
    
    //37. Создание острова
    static func populateSprite(at point: CGPoint) -> Cloud {
        
        //42. Запись в свойство рандомного имени из функции 15
        let cloudImageName = configureName()
        
        //17. Создание спрайта острова по имени из @42
        let cloud = Cloud(imageNamed: cloudImageName)
        
        //43. Изменение масштаба в щависимости от полученного рандомного числа.
        cloud.setScale(randomScaleFactor)
        
        //47. Координата острова
        cloud.position = point
        
        //48. Высота слоя
        cloud.zPosition = 10
        
        //49. Размытие облаков (от 0 до 1) 0 полностью прозрачен.
        cloud.alpha = 0.75
        
        return cloud
    }
    
    //38. Функция для создания рандомного имени файла с изображением острова, чтобы острова создавались в рандомном порядке
    private static func configureName() -> String {
        
        //39. Рандомное число от 1 до 4
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 3)
        
        //40. Возвращает число
        let randomNumber = distribution.nextInt()
        
        //41. Т.к имена файлов все одинаковые "cl1 cl2 cl3" то буду добавлять к is это рандомное число
        let imageName = "cl" + "\(randomNumber)"
        
        return imageName
        
        
    }
    
    //44. Свойство для рандомного числа, чтобы все острова имели разный масштаб картинки
    private static var randomScaleFactor: CGFloat {
    
    //45. Диапазон чисел
    let distribution = GKRandomDistribution(lowestValue: 20, highestValue: 30)
    
    //46. Рандомное число
    let randomNumber = CGFloat(distribution.nextInt()) / 10
    
    return randomNumber
}
    
   
}
