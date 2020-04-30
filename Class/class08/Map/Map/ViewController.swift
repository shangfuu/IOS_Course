//
//  ViewController.swift
//  Map
//
//  Created by mac07 on 2020/4/30.
//  Copyright © 2020 mac07. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let mapView = view.subviews.first as? MKMapView
        let ann = MKPointAnnotation()
        ann.coordinate = CLLocationCoordinate2D(latitude: 24.120305, longitude: 120.650916)
        mapView?.addAnnotation(ann)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        
        var annView = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annView == nil {
            annView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
        }
        
        annView?.image = UIImage(named: "coffee_to_go_rL1_icon.ico")
        return annView
        
    }

}

