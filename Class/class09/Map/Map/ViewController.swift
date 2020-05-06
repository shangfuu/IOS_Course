//
//  ViewController.swift
//  Map
//
//  Created by mac07 on 2020/4/30.
//  Copyright © 2020 mac07. All rights reserved.
//

import UIKit
import MapKit
import SafariServices

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    enum Map {
        case GPS
        case MAP_3D
        case DEFAULT
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set map TYPE
        let type = Map.DEFAULT
                
        // 導航
        if type == Map.GPS {
            //設定座標
            let taipei101 = CLLocationCoordinate2D(latitude: 25.033850, longitude: 121.564977)
            let airstaion = CLLocationCoordinate2D(latitude: 25.068554, longitude: 121.552932)
            
            //根據坐標得到地標
            let pA = MKPlacemark(coordinate: taipei101, addressDictionary: nil)
            let pB = MKPlacemark(coordinate: airstaion, addressDictionary: nil)
            
            //根據地標建立地圖項目
            let miA = MKMapItem(placemark: pA)
            let miB = MKMapItem(placemark: pB)
            miA.name = "台北101"
            miA.name = "松山機場"
            
            //將起訖點放到陣列中
            let routes = [miA, miB]
            
            //設定為開車模式
            let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            
            //開啟地圖開始導航
            MKMapItem.openMaps(with: routes, launchOptions: options)
        }
        // 3D 地圖
        else if type == Map.MAP_3D {
            // ground 為巴黎鐵塔的坐標
            let ground = CLLocationCoordinate2DMake(48.858356, 2.294481)
            // eyeFrom 為攝影機的座標
            let eyeFrom = CLLocationCoordinate2DMake(48.847, 2.294481)
            
            // 設定攝影機位置與高度
            let camera = MKMapCamera(lookingAtCenter: ground, fromEyeCoordinate: eyeFrom, eyeAltitude: 50)

            // 設定以3D衛星圖方式呈現
            mapView?.mapType = .satelliteFlyover
            
            // 允許可以從斜的方向觀看地圖，否則都是從正上方
            mapView?.isPitchEnabled = true
            
            // 地圖上加上攝影機
            mapView?.camera = camera
        }
        else {
            
            let mapView = view.subviews.first as? MKMapView
            let ann = MKPointAnnotation()
            ann.coordinate = CLLocationCoordinate2D(latitude: 24.120305, longitude: 120.650916)
            
            let ann_woolin = MKPointAnnotation()
            ann_woolin.coordinate = CLLocationCoordinate2D(latitude: 24.137426, longitude: 121.275753)
            ann_woolin.title = "武嶺"
            
            mapView?.addAnnotation(ann_woolin)
            mapView?.addAnnotation(ann)
            
            // 標示區域
            var points = [CLLocationCoordinate2D]()
            points.append(CLLocationCoordinate2D(latitude: 24.2013, longitude: 120.5810))
            points.append(CLLocationCoordinate2D(latitude: 24.2044, longitude: 120.6559))
            points.append(CLLocationCoordinate2D(latitude: 24.1380, longitude: 120.6401))
            points.append(CLLocationCoordinate2D(latitude: 24.1424, longitude: 120.5783))
            
            let polygon = MKPolygon(coordinates: &points, count: points.count)
            mapView?.addOverlay(polygon)
            
            // 切換地圖類型
            //衛星
            mapView?.mapType = .satellite
            //混合
            mapView?.mapType = .hybrid
            //標準
            mapView?.mapType = .standard
            
            
            // 座標轉地址
            let location = CLLocation(latitude: 25.102645, longitude: 121.548506)
            coordinatToAddress(location: location)
            
        }
        
    }
    @IBAction func onClick(_ sender: UIButton) {
        let request = MKLocalSearch.Request()
        
        // 可輸入地址或是關鍵字
        request.naturalLanguageQuery = "星巴克"
        
        // 這一行必須等地圖出現後才能得到正確的region資料
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard error == nil else{
                return
            }
            guard response != nil else {
                return
            }
            
            for item in (response?.mapItems)! {
                self.mapView
                    .addAnnotation(item.placemark)
            }
        }
    }
    
    func coordinatToAddress(location: CLLocation){
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard error == nil else{
                return
            }
            guard placemarks != nil else{
                return
            }
            
            for placemark in placemarks! {
                let addressDict = placemark.addressDictionary
                for key in (addressDict?.keys)! {
                    let value = addressDict?[key]
                    // 有時候 value 是 NSArray 型態
                    if value is NSArray{
                        for p in value as! NSArray{
                            print("=>\(key): \(p)")
                        }
                    }
                    // 有時候 value 是 String 型態
                    if value is String{
                        print("\(key): \(value!)")
                    }
                }
            }
        }
    }
    
    @objc func buttonPress(_ sender: UIButton){
        if sender.tag == 100{
            let url = URL(string: "http://www.taroko.gov.tw")
            let safari = SFSafariViewController(url: url!)
            show(safari, sender: self)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        
        var annView = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annView == nil {
            annView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
        }
        
        if (annotation.title)! == "武嶺" {
            // 設定左邊為一張圖片
            let imageView = UIImageView(image: resizeImage(image: UIImage(named: "wuling.jpg")!, width: 32))
            annView?.leftCalloutAccessoryView = imageView
            
            // 設定title下放一個標籤
            let label = UILabel()
            label.numberOfLines = 2
            label.text = "緯度：\(annotation.coordinate.latitude)\n經度:\(annotation.coordinate.longitude)"
            annView?.detailCalloutAccessoryView = label
            
            // 設定右邊為一個按鈕
            let button = UIButton(type: .detailDisclosure)
            button.tag = 100
            button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
            
            annView?.rightCalloutAccessoryView = button
        }
        else {
            annView?.image = UIImage(named: "coffee_to_go_rL1_icon.ico")
        }
        
        annView?.canShowCallout = true
        
        // Allow User to drag pin
        annView?.isDraggable = true
        
        return annView
        
    }
    
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        mapView.removeAnnotation(view.annotation!)
//    }
    
    func resizeImage(image: UIImage, width: CGFloat) -> UIImage{
        let size = CGSize(width: width, height: image.size.height * width / image.size.width)
        let renderer = UIGraphicsImageRenderer(size: size)
        let newImage = renderer.image {
            (context) in image.draw(in: renderer.format.bounds)
        }
        return newImage
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // MKPolygonRenderer 幾合區域
        // MKCirecleRenderer 圓形區域
        // MKPolyLineRenderer 線條
        
        let render = MKPolygonRenderer(overlay: overlay)
        if overlay is MKPolygon{
            render.fillColor = UIColor.red.withAlphaComponent(0.2)
            render.strokeColor = UIColor.red.withAlphaComponent(0.7)
            render.lineWidth = 3
            
        }
        return render
    }
    
}

