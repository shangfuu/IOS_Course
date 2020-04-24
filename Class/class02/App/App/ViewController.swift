//
//  ViewController.swift
//  App
//
//  Created by mac07 on 2020/3/11.
//  Copyright © 2020 mac07. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        IMG.contentMode = .scaleAspectFit
        IMG.image = UIImage(named: "Nodle.png")
        alpha.text = String(format: "%.1f", siderValue.value)
        
        // Set the secureText is default on
        numTextField.isSecureTextEntry = true
    }
    
    
    @IBOutlet weak var pickView: UIPickerView!
    
    let fontname = ["Symbol","Times New Roman","zapfino", "Chalkduster"]
    let fontsize = ["15","16","17","18","19","20","21","22","23","24","25"]
    
    
    // Inhance UIPickerView needed function
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // how many columns
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // how many row
        if component == 0 {
            return fontname.count
        }
        return fontsize.count
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    var currentFontSize:CGFloat = 20.0
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return fontname[row]
        }
        return fontsize[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            name.font = UIFont(name:fontname[row], size:currentFontSize)
            number.font = UIFont(name:fontname[row], size:currentFontSize)
        }
        else{
            currentFontSize = CGFloat(Double(fontsize[row])!)
            name.font = name.font.withSize(currentFontSize)
            number.font = number.font.withSize(currentFontSize)
        }
        
    }
    
    
    @IBOutlet weak var IMG: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numTextField: UITextField!
    
    @IBAction func bgTouchDown(_ sender: UIControl) {
        numTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
    }
    
    @IBAction func nameTextFielld(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
 
        
    @IBOutlet weak var alpha: UILabel!
    @IBOutlet weak var siderValue: UISlider!
    @IBOutlet weak var `switch`: UISwitch!
    
    
    @IBAction func alphaSlider(_ sender: UISlider) {
        
        
        alpha.text = String(format: "%.1f", sender.value)
        IMG.alpha = CGFloat(sender.value)
        IMG.image = UIImage(named: "Nodle.png")
    

    }
        
    @IBAction func secureText(_ sender: UISwitch) {
        
        if sender.isOn {
            numTextField.isSecureTextEntry = true
        }
        else{
            numTextField.isSecureTextEntry = false
        }
        
    }
    
    @IBAction func segmentCtrl(_ sender: UISegmentedControl) {
        // Close the slider, slidervalue and switch buutton in second segment
        if sender.selectedSegmentIndex == 0 {
            siderValue.isHidden = false
            alpha.isHidden = false
            `switch`.isHidden = false
            pickView.isHidden = false
        }
        else{
            siderValue.isHidden = true
            alpha.isHidden = true
            `switch`.isHidden = true
            pickView.isHidden = true
        }
    }
    
}

