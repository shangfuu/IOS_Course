//
//  PageViewController.swift
//  Delegation
//
//  Created by mac07 on 2020/5/14.
//  Copyright © 2020 NTUST. All rights reserved.
//

import UIKit

protocol PageViewControllerDelegate: class {
    
    // 設定頁數
    func pageViewController(_ pageViewController: PageViewController, didUpdateNumberOfPage numberOfPage: Int)
    
    // 當 pageViewController 切換頁數時，設定 pageControl 的頁數
    func pageViewController(_ pageViewController: PageViewController, didUpdatePageIndexpageIndex: Int)
}

class PageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
