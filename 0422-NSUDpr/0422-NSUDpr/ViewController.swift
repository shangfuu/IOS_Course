//
//  ViewController.swift
//  0422-NSUDpr
//
//  Created by mac07 on 2020/4/22.
//  Copyright © 2020 mac07. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var userDefault: UserDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let name: String? = userDefault.object(forKey: "userName") as! String?
        if name == nil {
            alertBtn("Enter the name", Message: "Welcome to this app", BtnTitle: "Yes")
        } else{
            let msg:String = "Hello " + name!
            alertBtn("Welcome", Message: msg, BtnTitle: "Yes")
        }
    }
    
    
    @IBOutlet weak var textName: UITextField!
    
    @IBAction func saveClick(_ sender: UIButton) {
        userDefault.set(textName.text, forKey: "userName")
        userDefault.synchronize()
        alertBtn("W", Message: "written!", BtnTitle: "Yes")
    }
    
    @IBAction func deleteCllick(_ sender: UIButton) {
        userDefault.removeObject(forKey: "userName")
        textName.text = ""
        alertBtn("C", Message: "Cleared", BtnTitle: "Yes")
    }
    
    
    
    
    func alertBtn(_ Title: String, Message: String, BtnTitle: String) {
        let alertController = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        let action = UIAlertAction(title: BtnTitle, style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController,animated:
        true,completion: nil)
    }


}

