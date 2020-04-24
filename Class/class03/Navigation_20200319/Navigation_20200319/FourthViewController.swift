//
//  ForthViewController.swift
//  Navigation_20200319
//
//  Created by mac07 on 2020/3/19.
//  Copyright © 2020 mac07. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toNext(_ sender: UIButton) {
        guard (self.navigationController?.popToRootViewController(animated: true)) != nil else {
            print("No Navigation Controller")
            return
        }
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        guard (self.navigationController?.popViewController(animated: true)) != nil else {
            print("No Navigation Controller")
            return
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
