//
//  MapViewController.swift
//  MyLocations
//
//  Created by Sean Perez on 8/3/16.
//  Copyright © 2016 SeanPerez. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var managedObjectContext: NSManagedObjectContext!
    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLocations()
    }
    
    @IBAction func showUser() {
        let region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
    @IBAction func showLocations() {
        
    }
    
    func updateLocations() {
        mapView.removeAnnotations(locations)
        let entity = NSEntityDescription.entityForName("Location", inManagedObjectContext: managedObjectContext)
        let fetchedRequest = NSFetchRequest()
        fetchedRequest.entity = entity
        locations = try! managedObjectContext.executeFetchRequest(fetchedRequest) as! [Location]
        mapView.addAnnotations(locations)
    }
}

extension MapViewController: MKMapViewDelegate {
    
}
