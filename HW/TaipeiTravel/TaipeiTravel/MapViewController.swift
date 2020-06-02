//
//  MapViewController.swift
//  TaipeiTravel
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {
    
    let fullSize :CGSize = UIScreen.main.bounds.size
    let myUserDefaults :UserDefaults = UserDefaults.standard
    var fetchType :String = ""
    var info :[String:AnyObject]! = nil
    var latitude :Double = 0.0
    var longitude :Double = 0.0
    var myMapView :MKMapView!
    let objectAnnotation = MKPointAnnotation()
    
    var subtitle: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 樣式
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        
        latitude = info["latitude"] as? Double ?? 0.0
        longitude = info["longitude"] as? Double ?? 0.0
        subtitle = info["address"] as? String ?? ""
        
        self.title = info["title"] as? String ?? "標題"
        
        // 建立一個 MKMapView
        myMapView = MKMapView(frame: CGRect(x: 0, y: 0, width: fullSize.width, height: fullSize.height - 113))
        
        // 設置委任對象
        myMapView.delegate = self
        
        // 地圖樣式
        myMapView.mapType = .standard
        
        // 顯示自身定位位置
        myMapView.showsUserLocation = true
        
        // 允許縮放地圖
        myMapView.isZoomEnabled = true
        
        
        // 地圖預設顯示的範圍大小 (數字越小越精確)
        let latDelta = 0.005
        let longDelta = 0.005
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        // 設置地圖顯示的範圍與中心點座標
        let center:CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate, span: currentLocationSpan)
        myMapView.setRegion(currentRegion, animated: true)
        
        // 加入到畫面中
        self.view.addSubview(myMapView)
        
        // 建立一個地點圖示 (圖示預設為紅色大頭針)
        self.objectAnnotation.coordinate = CLLocation(latitude: latitude, longitude: longitude).coordinate
        self.objectAnnotation.title = self.title
        self.objectAnnotation.subtitle = self.subtitle
        myMapView.addAnnotation(self.objectAnnotation)
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Select PIN")
        
        let actionController = UIAlertController(title: nil, message: "選擇功能", preferredStyle: .actionSheet)
        
        let GPSAction = UIAlertAction(title: "導航", style: .default) { (action) in
            // 初始化 MKPlacemark
            let targetPlacemark = MKPlacemark(coordinate: self.objectAnnotation.coordinate)
            // 透過 targetPlacemark 初始化一個 MKMapItem
            let targetItem = MKMapItem(placemark: targetPlacemark)
            // 使用當前使用者當前座標初始化 MKMapItem
            let userMapItem = MKMapItem.forCurrentLocation()
            // 建立導航路線的起點及終點 MKMapItem
            let routes = [userMapItem,targetItem]
            // 設定為開車模式
            let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            MKMapItem.openMaps(with: routes, launchOptions: options)
        }
        let cancleAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        actionController.addAction(GPSAction)
        actionController.addAction(cancleAction)
        
        present(actionController, animated: true, completion: nil)
    }
    
}
