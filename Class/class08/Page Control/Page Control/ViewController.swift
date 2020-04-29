//
//  ViewController.swift
//  Page Control
//
//  Created by mac07 on 2020/4/29.
//  Copyright © 2020 mac07. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var images = [UIImage]()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        images.append(UIImage(named: "01.jpg")!)
        images.append(UIImage(named: "02.jpg")!)
        images.append(UIImage(named: "03.jpg")!)
        
        imageView.image = images[0]
        pageControl.numberOfPages = images.count
    }

    
    @IBAction func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        
        switch sender.direction {
        case UISwipeGestureRecognizer.Direction.left:
            if pageControl.currentPage < images.count {
                pageControl.currentPage += 1
            }
            if pageControl.currentPage == images.count {
                pageControl.currentPage = 0
                print("YEE")
            }
            
            print(pageControl.currentPage, images.count - 1)
            break
            
        case UISwipeGestureRecognizer.Direction.right:
            if pageControl.currentPage > 0{
                pageControl.currentPage -= 1
            }
            else if pageControl.currentPage == 0 {
                pageControl.currentPage = images.count - 1
            }
            break
        default:
            break
        }
        imageView.image = images[pageControl.currentPage]
    }
    

}

