//
//  MapVC.swift
//  LambdaTimeline
//
//  Created by Seschwan on 9/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapTypeSegmentPicker: UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func mapTypeChanged(_ sender: UISegmentedControl) {
//        if sender.selectedSegmentIndex == 3 {
//            mapView.mapType = MKMapType.init(rawValue: 4) ?? .standard
//        }
        mapView.mapType = MKMapType.init(rawValue: UInt(sender.selectedSegmentIndex)) ?? .standard
    }
    
}
