//
//  ViewController.swift
//  Hw1
//
//  Created by shungfu on 2020/3/18.
//  Copyright © 2020 shungfu. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let symbol = ["🏧","🔞","♻","💈","🌍","🗼"]
    var score = 0
    var col1 = [String]()
    var col2 = [String]()
    var col3 = [String]()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return col1.count
        }
        else if component == 1 {
            return col2.count
        }
        return col3.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return col1[row]
        }
        else if component == 1{
            return col2[row]
        }
        return col3[row]
    }
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var scoreBoard: UILabel!
    @IBOutlet weak var pickView: UIPickerView!
    
    @IBAction func startBtn(_ sender: UIButton) {
        pickView.selectRow(Int(arc4random()) % 100, inComponent: 0, animated: true)
        pickView.selectRow(Int(arc4random()) % 100, inComponent: 1, animated: true)
        pickView.selectRow(Int(arc4random()) % 100, inComponent: 2, animated: true)
        
        print(col1[pickView.selectedRow(inComponent: 0)])
        print(col2[pickView.selectedRow(inComponent: 1)])
        print(col3[pickView.selectedRow(inComponent: 2)])
        
        if col1[pickView.selectedRow(inComponent: 0)] == col2[pickView.selectedRow(inComponent: 1)] && col2[pickView.selectedRow(inComponent: 1)] == col3[pickView.selectedRow(inComponent: 2)]{
            
            print("BINGO")
            // Bingo Alert
            let bingoAlert = UIAlertController(title: "BINGO!!!", message: "加10分！", preferredStyle: .alert)
            let bingoAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            bingoAlert.addAction(bingoAction)
            present(bingoAlert, animated: true, completion: nil)
            
            score = score + 10
            scoreBoard.text = "分數：\(score)"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        for _ in 1...100{
            col1.append(symbol[(Int)(arc4random() % 6)])
            col2.append(symbol[(Int)(arc4random() % 6)])
            col3.append(symbol[(Int)(arc4random() % 6)])
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        // Make action when view is loaded
        func login() {
            
            // Alert input Account Controller
            let warnAccAlert = UIAlertController(title: "請輸入帳號或密碼", message: "", preferredStyle: .alert)
            // Login Alert Controller
            let loginAlert = UIAlertController(title: "登入", message: "請輸入帳號密碼", preferredStyle: .alert)
            
            // Rules Alert Controller
            let rulesAlert = UIAlertController(title: "規則", message: "當拉霸機連線相同時即得10分", preferredStyle: .alert)
            // Add Rules Alert button
            let rulesAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            rulesAlert.addAction(rulesAction)
            
            // Add Account input Alert button
            let warnAction = UIAlertAction(title: "OK", style: .default){ (action) in
                self.present(loginAlert, animated: true, completion: nil)
            }
            warnAccAlert.addAction(warnAction)
            
            // Add Login Alert Action button
            let cancelAction = UIAlertAction(title: "取消", style: .cancel){ (action) in
                self.dismiss(animated: true, completion: nil)
            }
            loginAlert.addAction(cancelAction)
            
            let loginAction = UIAlertAction(title: "登入", style: .default){(action) in
                let acc = (loginAlert.textFields?.first)! as UITextField
                let password = (loginAlert.textFields?.last)! as UITextField
                
                if acc.text != "" && password.text != ""{
                    self.userName.text = "Hello, \(acc.text!)"
                    self.present(rulesAlert, animated: true, completion: nil)
                }
                else{
                    self.present(warnAccAlert, animated: true, completion: nil)
                }
                print("帳號為：\(acc.text)")
                print("密碼為：\(password.text)")
            }
            loginAlert.addAction(loginAction)
            
            // Add textfield
            loginAlert.addTextField{ (textField) in
                textField.placeholder = "Login";
            }
            loginAlert.addTextField{ (textField) in
                textField.placeholder = "Password";
                textField.isSecureTextEntry = true;
            }
            
            // Show Login Alert
            present(loginAlert, animated: true, completion: nil)
        }
        login()
    }
    
}


