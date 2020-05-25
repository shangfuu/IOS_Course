//
//  AppDelegate.swift
//  TaipeiTravel
//
//  Created by joe feng on 2016/6/6.
//  Copyright © 2016年 hsin. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    
    var window: UIWindow?
    var myLocationManager: CLLocationManager!
    var myUserDefaults: UserDefaults!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 取得儲存的預設資料
        self.myUserDefaults = UserDefaults.standard
        
        // 建立一個CLLocationManager
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        myLocationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        myLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        // 首次使用，向使用者詢問定位自身位置權限
        if CLLocationManager.authorizationStatus() == .notDetermined{
            // 取得定位服務授權
            myLocationManager.requestWhenInUseAuthorization()
        }
        else if CLLocationManager.authorizationStatus() == .denied {
            // 設置定位權限的紀錄
            self.myUserDefaults.set(false, forKey: "locationAuth")
            self.myUserDefaults.synchronize()
        }
        else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // 設置定位權限的紀錄
            self.myUserDefaults.set(true, forKey: "locationAuth")
            
            for type in ["hotel", "landmark", "park", "toilet"] {
                self.myUserDefaults.set(0.0, forKey: "\(type)RecordLatitude")
                self.myUserDefaults.set(0.0, forKey: "\(type)RecordLongtitude")
            }
            
            self.myUserDefaults.synchronize()
        }
        
        // 設定導覽列預設底色
        UINavigationBar.appearance().barTintColor = UIColor.init(red: 0.24, green: 0.79, blue: 0.83, alpha: 1)
        
        // 設定導覽列按鈕顏色
        UINavigationBar.appearance().tintColor = UIColor.black
        
        // 建立一個 UIWindow
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        // 建立 UITabBarController
        let myTabBar = UITabBarController()
        
        // 使用 NavigationController實作Detial切換頁面
        // 建立 “景點” 頁面
        let  landmarkViewController = UINavigationController(rootViewController: LandmarkMainViewController())
        landmarkViewController.tabBarItem = UITabBarItem(title: "景點", image: UIImage(named: "landmark"), tag: 2000)
        
        // 建立 “公園” 頁面
        let parkViewController = UINavigationController(rootViewController: ParkViewController())
        parkViewController.tabBarItem = UITabBarItem(title: "公園", image: UIImage(named: "park"), tag: 300)
        
        // 建立 “廁所” 頁面
        let toiletViewController = UINavigationController(rootViewController: ToiletViewController())
        toiletViewController.tabBarItem = UITabBarItem(title: "廁所", image: UIImage(named: "toilet"), tag: 400)
        
        // 建立 “餐廳” 頁面
        let foodViewController = UINavigationController(rootViewController: FoodViewController())
        foodViewController.tabBarItem = UITabBarItem(title: "餐廳", image: UIImage(named: "hotel"), tag: 100)
        
        // 建立 “關於” 頁面
        let infoViewController = UINavigationController(rootViewController: InfoViewController())
        infoViewController.tabBarItem = UITabBarItem(title: "關於", image: UIImage(named: "info"), tag: 500)
        
        // 加入到 UITabBarController
        myTabBar.viewControllers = [landmarkViewController, parkViewController, toiletViewController, foodViewController, infoViewController]
        
        // 設置根視圖控制器
        self.window!.rootViewController = myTabBar
        
        // 將 UIWindow 設置為可見
        self.window!.makeKeyAndVisible()
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.denied {
            // 提示可至[設定]中開啟權限
            let alertController = UIAlertController(title: "定位服務已關閉", message: "如要變更權限，請至 設定>隱私權>定位服務 開啟", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            // 設置定位權限的紀錄
            self.myUserDefaults.set(false, forKey: "locationAuth")
            self.myUserDefaults.synchronize()
        }
        else if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            self.myUserDefaults.set(true, forKey: "locationAuth")
            self.myUserDefaults.synchronize()
        }
    }
    
}

