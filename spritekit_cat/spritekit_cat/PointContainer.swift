//
//  PointContainer.swift
//  spritekit_cat
//
//  Created by mac07 on 2020/4/15.
//  Copyright © 2020 mac07. All rights reserved.
//

import SpriteKit

class PointContainer: SKNode {
    
    let cat = Cat()
    let textPoint1 = SKTexture(imageNamed: "pot1")  // grey dot pic
    let textPoint2 = SKTexture(imageNamed: "pot2")  // red dot pic
    var arrPoint = [EPoint]()   // record all dot
    let startIndex = 40
    var currentIndex = 40
    var isFind = false
    
    var arrNext = [Int]()
    
    // Change the type of dot
    func onSetRed(_ index: Int){
        arrPoint[index].type = pointtype.red
        arrPoint[index].texture = textPoint2
    }
    
    // Random generate red point
    func onCreateRed(){
        for i in 0...8{
            let r1 = Int(arc4random() % 9) + i * 9
            let r2 = Int(arc4random() % 9) + i * 9

            if r1 != startIndex {
                onSetRed(r1)
            }
            if r2 != startIndex{
                onSetRed(r2)
            }
            
        }
    }
    
    func onGetPosition(_ index:Int)->CGPoint{
        return CGPoint(x: arrPoint[index].position.x, y: arrPoint[index].position.y)
    }
    
    // 處理Cat下一步要怎麼走，index目前所點到的node'x index
    func onGetNextPoint(_ index: Int){
        onSetRed(index)
        for point in arrPoint[currentIndex].aroundPoint {
            // 判斷下一步是否為出口
            if arrPoint[point].isEdge && arrPoint[point].type == pointtype.gray{
                gameReset("You loss!")
            }
        }
        
        // 尋找路徑的資料還原並設定cat所在點的step
        onResetStep()
        let currPoint = arrPoint[currentIndex]
        currPoint.step = 0
        
        // 開始尋找路徑開始
        arrNext.append(currentIndex)
        onFind(arrNext)
        
        if !isFind {
            gameReset("You win !")
        }
    }
    
    // 用來中路徑狀態與step
    func onResetStep(){
        arrNext = [Int]()
        isFind = false
        for p in arrPoint{
            p.step = 99
            p.prePointIndex = -1
        }
    }
    // 如果找到邊緣點就停止遞迴
    func onFind(_ arrNext:[Int]){
        if !isFind {
            let arrNext = onGetNexts(arrNext)
            if arrNext.count != 0{
                onFind(arrNext)
            }
        }
    }
    //用來尋找路徑
    func onGetNexts(_ arrNext:[Int])->[Int]{
        let step = arrPoint[arrNext[0]].step + 1
        var tempPoints = [Int]()
        for nextP in arrNext{
            if isFind{
                break
            }
            for p in arrPoint[nextP].aroundPoint{
                if arrPoint[p].isEdge && arrPoint[p].type == pointtype.gray{
                    isFind = true
                    onGetPrePoint(arrPoint[p])
                    break
                }
                else if (arrPoint[p].type == pointtype.gray) && (arrPoint[p].step > arrPoint[nextP].step){
                    arrPoint[p].step = step
                    arrPoint[p].prePointIndex = arrPoint[nextP].index
                    if arrPoint[p].index != arrPoint[nextP].prePointIndex{
                        tempPoints.append(p)
                    }
                }
            }
        }
        return tempPoints
    }
    
    //
    func onGetPrePoint(_ point: EPoint){
        var p2 = point.aroundPoint[0]
        for p in point.aroundPoint{
            if arrPoint[p].step < arrPoint[p2].step{
                p2 = p
            }
        }
        if arrPoint[p2].step == 0{
            cat.position = onGetPosition(point.index)
            self.currentIndex = point.index
        }
        else {
            onGetPrePoint(arrPoint[p2])
        }
    }
    
 
    
    //
    func gameReset(_ result: String) {
        let alert = UIAlertController(title: result, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Again", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.scene?.view?.window?.rootViewController?.present(alert,animated: true, completion: nil)
        
        for point in arrPoint {
            point.type = pointtype.gray
            point.texture = textPoint1
        }
        
        cat.position = onGetPosition(startIndex)
        currentIndex = startIndex
        onCreateRed()
        onResetStep()
    }
    
     func onInit() {
           for i in 0...80 {
               let point = EPoint(texture: textPoint1)
               let row = Int (i/9)
               let col = i%9
               var gap = 0
               
               if Int(row % 2) == 1 {
                   gap = 19
               }
               
               let width = Int(textPoint1.size().width)
               let x = CGFloat(col * (width + 5) - (9 * width) / 2 + gap)
               let y = CGFloat(row * width - (9 * width) / 2)
               point.position = CGPoint(x: x, y: y)
               
               if row == 0 || row == 8 || col == 0 || col == 8 {
                   point.isEdge = true
               }
               point.index = i
               point.zPosition = 10
               addChild(point)
               arrPoint.append(point)
           }
           
           cat.position = onGetPosition(startIndex)
           cat.zPosition = 20
           addChild(cat)
           
           onData()
           onCreateRed()
       }
       
    
   func onData() {
           for point in arrPoint {
               let row = Int(point.index / 9)
               if Int(row % 2) == 1 {
                   if point.index - 1 >= 0 && point.index - 1 <= 80 {
                       point.aroundPoint.append(point.index - 1)
                   }
                   if point.index + 9 >= 0 && point.index + 9 <= 80 {
                       point.aroundPoint.append(point.index + 9)
                   }
                   if point.index + 10 >= 0 && point.index + 10 <= 80 {
                       point.aroundPoint.append(point.index + 10)
                   }
                   if point.index + 1 >= 0 && point.index + 1 <= 80 {
                       point.aroundPoint.append(point.index + 1)
                   }
                   if point.index - 8 >= 0 && point.index - 8 <= 80 {
                       point.aroundPoint.append(point.index - 8)
                   }
                   if point.index - 9 >= 0 && point.index - 9 <= 80 {
                       point.aroundPoint.append(point.index - 9)
                   }
               }
               else {
                   if point.index - 1 >= 0 && point.index - 1 <= 80 {
                       point.aroundPoint.append(point.index - 1)
                   }
                   if point.index + 8 >= 0 && point.index + 8 <= 80 {
                       point.aroundPoint.append(point.index + 8)
                   }
                   if point.index + 9 >= 0 && point.index + 9 <= 80 {
                       point.aroundPoint.append(point.index + 9)
                   }
                   if point.index + 1 >= 0 && point.index + 1 <= 80 {
                       point.aroundPoint.append(point.index + 1)
                   }
                   if point.index - 9 >= 0 && point.index - 9 <= 80 {
                       point.aroundPoint.append(point.index - 9)
                   }
                   if point.index - 10 >= 0 && point.index - 10 <= 80 {
                       point.aroundPoint.append(point.index - 10)
                   }
               }
           }
       }

}

