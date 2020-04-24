//
//  ViewController.swift
//  0422-DatawithFile
//
//  Created by mac07 on 2020/4/22.
//  Copyright © 2020 mac07. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var arrayTitle:Array<String> = []
    var arrayContent:Array<String> = []

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textContent: UILabel!
    @IBOutlet weak var labelNum: UILabel!
    @IBOutlet weak var stepperBook: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var path = Bundle.main.path(forResource: "01", ofType: "txt")! as NSString
        let imgName = try? Data(contentsOf: URL(fileURLWithPath: path as String))
        let imgString = NSString(data: imgName!, encoding: String.Encoding.utf8.rawValue)! as String
        let arratyImage = imgString.components(separatedBy: "\n")
        
        for i in 0...arratyImage.count-2 {
            let arrayTemp = arratyImage[i].components(separatedBy: ";")
            arrayTitle.append(arrayTemp[1])
        }
        
        path = Bundle.main.path(forResource: "02", ofType: "txt")! as NSString
        let contentData = try? Data(contentsOf: URL(fileURLWithPath: path as String))
        let contentString : String = NSString(data: contentData! as Data, encoding: String.Encoding.utf8.rawValue)! as String
        arrayContent = contentString.components(separatedBy: "\n")
        
        labelTitle.text = arrayTitle[0]
        textContent.text = arrayContent[0]
        
        stepperBook.minimumValue = 0
        stepperBook.maximumValue = Double(arrayTitle.count) + 1
        stepperBook.value = 1
    }
    
    @IBAction func stepperChange(_ sender: UIStepper) {
        var num = Int(stepperBook.value)
        if num == arrayTitle.count + 1{
            num = 1
            stepperBook.value = 1
        }
        else if num == 0 {
            num = arrayTitle.count
            stepperBook.value = Double(arrayTitle.count)
        }
        labelTitle.text = arrayTitle[num-1]
        textContent.text = arrayContent[num-1]
        labelNum.text = String(num)
    }
    
}

