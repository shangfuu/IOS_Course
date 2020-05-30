
import UIKit
import CoreLocation

let TABLIST = ["toilet"]

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var myLocationManager: CLLocationManager!
    var myUserDefaults: UserDefaults!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 取得儲存的預設資料
        self.myUserDefaults = UserDefaults.standard

        // 建立一個 CLLocationManager
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        myLocationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        myLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        // 首次使用 向使用者詢問定位自身位置權限
        if CLLocationManager.authorizationStatus() == .notDetermined {
            // 取得定位服務授權
            myLocationManager.requestWhenInUseAuthorization()
            
            // 設定後的動作請至委任方法
            // func locationManager(
            //   manager: CLLocationManager,
            //   didChangeAuthorizationStatus status: CLAuthorizationStatus)
            // 設置
        } else if (CLLocationManager.authorizationStatus() == .denied) {
            // 設置定位權限的紀錄
            self.myUserDefaults.set(false, forKey: "locationAuth")

            self.myUserDefaults.synchronize()
        } else if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            // 設置定位權限的紀錄
            self.myUserDefaults.set(true, forKey: "locationAuth")
            
            // 更新記錄的座標 for 取得有限數量的資料
            for type in TABLIST {
                self.myUserDefaults.set(0.0, forKey: "\(type)RecordLatitude")
                self.myUserDefaults.set(0.0, forKey: "\(type)RecordLongitude")
            }
            self.myUserDefaults.synchronize()
        }
        
        // LightCyan4: 122 139 139
        // 設定導覽列預設底色
        UINavigationBar.appearance().barTintColor = UIColor.init(red: 122/255, green: 139/255, blue: 139/255, alpha: 1)
        
        // 設定導覽列預設按鈕顏色
        UINavigationBar.appearance().tintColor = UIColor.black

        // 建立一個 UIWindow
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        // 建立 UITabBarController, DarkSlateGray:47 79 79, grey51: 130 130 130
        let myTabBar = UITabBarController()
        myTabBar.tabBar.tintColor = UIColor.init(red: 47/255, green: 79/255, blue: 79/255, alpha: 1)
        myTabBar.tabBar.backgroundColor = UIColor.init(red: 105/255, green: 105/255, blue: 105/255, alpha: 0.7)
     
        // 建立 廁所 頁面
        let toiletViewController = UINavigationController(rootViewController: ToiletMainViewController())
        toiletViewController.tabBarItem = UITabBarItem(title: "廁所", image: UIImage(named: "toilet"), tag: 400)
        
        // 建立 關於 頁面
        let infoViewController = UINavigationController(rootViewController: InfoMainViewController())
        infoViewController.tabBarItem = UITabBarItem(title: "關於", image: UIImage(named: "info"), tag: 500)
        
        // 加入到 UITabBarController
        myTabBar.viewControllers = [toiletViewController, infoViewController]
        
        // 設置根視圖控制器
        self.window!.rootViewController = myTabBar
        
        // 將 UIWindow 設置為可見的
        self.window!.makeKeyAndVisible()
        
        return true
    }

// MARK: CLLocationManagerDelegate Methods
    
    // 更改定位權限時執行
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
            // 提示可至[設定]中開啟權限
            let alertController = UIAlertController( title: "定位服務已關閉", message: "如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .default, handler:nil)
            alertController.addAction(okAction)
            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            // 設置定位權限的紀錄
            self.myUserDefaults.set(false, forKey: "locationAuth")
            self.myUserDefaults.synchronize()
        } else if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            // 設置定位權限的紀錄
            self.myUserDefaults.set(true, forKey: "locationAuth")
            self.myUserDefaults.synchronize()
        }
    }
    
}

