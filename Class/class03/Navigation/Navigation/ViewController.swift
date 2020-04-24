//
//  ViewController.swift
//  Navigation
//
//  Created by mac07 on 2020/3/18.
//  Copyright © 2020 mac07. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "首頁"
        self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
    }

    @IBAction func toSecondView(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SecondViewController"){
            show(vc, sender: self)
        }
    }
    
}

