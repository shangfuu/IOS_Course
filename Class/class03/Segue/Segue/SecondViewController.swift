//
//  secondViewController.swift
//  Segue
//
//  Created by mac07 on 2020/3/18.
//  Copyright © 2020 mac07. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var recieveStr :String? = nil
    var sendBackStr :String? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        secondLabel.text = "SecondView"
        
        if let str = recieveStr{
            secondLabel.text = str
        }
        
        sendBackStr = "Back from second View"
    }
    
    @IBOutlet weak var secondLabel: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
