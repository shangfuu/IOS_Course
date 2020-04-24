//
//  DetailViewController.swift
//  Hw2_B10615045
//
//  Created by shungfu on 2020/4/8.
//  Copyright © 2020 shungfu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Name: UILabel!
    
    var receive_img: UIImage? = nil
    var receive_name: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let img = receive_img{
            Image.image = img
        }
        if let name = receive_name{
            Name.text = "名稱: \t" + name
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
