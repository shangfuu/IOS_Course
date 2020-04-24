//
//  SecondViewController.swift
//  Navigation_20200319
//
//  Created by mac07 on 2020/3/19.
//  Copyright © 2020 mac07. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    let gradientLayer = CAGradientLayer()
    func createGradientayer() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = [UIColor.gray.cgColor, UIColor.black.cgColor]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createGradientayer()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func toNext(_ sender: UIButton) {
        let mystoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mystoryBoard.instantiateViewController(identifier: "ThirdVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func back(_ sender: UIButton) {
        guard (self.navigationController?.popViewController(animated: true)) != nil else {
            print("No Navigation Controller")
            return
        }
    }
    
}
