//
//  ViewController.swift
//  Navigation_20200319
//
//  Created by mac07 on 2020/3/19.
//  Copyright © 2020 mac07. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let gradientLayer = CAGradientLayer()
    func createGradientLayer () {
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.blue.cgColor]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createGradientLayer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func toSecond(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "SecondVC") {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func toThird(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "ThirdVC")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

