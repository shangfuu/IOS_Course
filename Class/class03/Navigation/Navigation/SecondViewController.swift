//
//  SecondViewController.swift
//  Navigation
//
//  Created by mac07 on 2020/3/18.
//  Copyright © 2020 mac07. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        self.title = "Second VC"
    }
    

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backToMain(_ sender: UIButton) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "ViewController")
        show(vc, sender: self)
    }
}
