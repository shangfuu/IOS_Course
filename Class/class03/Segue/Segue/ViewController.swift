//
//  ViewController.swift
//  Segue
//
//  Created by mac07 on 2020/3/18.
//  Copyright © 2020 mac07. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func unwindSegue(for segue: UIStoryboardSegue){
        if segue.identifier == "unwind_segue"{
            let vc = segue.source as! SecondViewController
            if let str = vc.sendBackStr{
                firstLabel.text = str
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_1to2"{
            let vc = segue.destination as? SecondViewController
            vc!.recieveStr = "Helllo, secondView"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBOutlet weak var firstLabel: UILabel!
}

