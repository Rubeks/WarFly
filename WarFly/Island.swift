//
//  Island.swift
//  WarFly
//
//  Created by Раис Аглиуллов on 19/04/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import SpriteKit
import GameplayKit

//13. Класс для Островов
final class Island: SKSpriteNode, GameBackgroundSpriteable {
    
    //14. Создание острова
    static func populateSprite(at point: CGPoint) -> Island {
        
        //16. Запись в свойство рандомного имени из функции 15
        let islandImageName = configureIslandName()
        
        //17. Создание спрайта острова по имени из 16
        let island = Island(imageNamed: islandImageName)
        
        //21. Изменение масштаба в щависимости от полученного рандомного числа.
        island.setScale(randomScaleFactor)
        
        //27. Координата острова
        island.position = point
        
        //28. Высота слоя
        island.zPosition = 1
        
        //29. Вращение острова по функции 25
        island.run(rotateForRandomAngle())
        
        //56. Движение острова
        island.run(move(from: point))
        
        return island
    }
    
    //15. Функция для создания рандомного имени файла с изображением острова, чтобы острова создавались в рандомном порядке
    private static func configureIslandName() -> String {
        
        //22. Рандомное число от 1 до 4
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 4)
        
        //23. Возвращает число
        let randomNumber = distribution.nextInt()
        
        //24. Т.к имена файлов все одинаковые "is1 is2 is3 is4" то буду добавлять к is это рандомное число
        let imageName = "is" + "\(randomNumber)"
        
        return imageName
        
        
    }
    
    //18. Свойство для рандомного числа, чтобы все острова имели разный масштаб картинки
    private static var randomScaleFactor: CGFloat {
        
        //19. Диапазон чисел
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 10)
        
        //20. Рандомное число
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
    
    //25. Функция для вращения острова, чтобы все они смотрели в разные стороны
    private static func rotateForRandomAngle() -> SKAction {
        
        //26. От 0 до 360 т.е полный круг
        let distribution = GKRandomDistribution(lowestValue: 0, highestValue: 360)
        
        let randomNumber = CGFloat(distribution.nextInt())
        
        //Возвращает экшен вращение против часовой стрелки
        return SKAction.rotate(toAngle: randomNumber * CGFloat(Double.pi / 180), duration: 0)
        
    }
    
    //51. Функция для движения острова
    private static func move(from point: CGPoint) -> SKAction {
        
        //52. Точка конечная куда смещаться
        let movePoint = CGPoint(x: point.x, y: -200)
        
        //53. Расстояние смещения
        let moveDistance = point.y + 200
        
        //54. Скорость движения
        let movementSpeed: CGFloat = 20.0
        
        //55.
        let duration = moveDistance / movementSpeed
        
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
}
