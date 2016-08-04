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
        
        if !locations.isEmpty {
            showLocations()
        }
    }
    
    @IBAction func showUser() {
        let region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
    @IBAction func showLocations() {
        let region = regionForAnnotations(locations)
        mapView.setRegion(region, animated: true)
    }
    
    func updateLocations() {
        mapView.removeAnnotations(locations)
        let entity = NSEntityDescription.entityForName("Location", inManagedObjectContext: managedObjectContext)
        let fetchedRequest = NSFetchRequest()
        fetchedRequest.entity = entity
        locations = try! managedObjectContext.executeFetchRequest(fetchedRequest) as! [Location]
        mapView.addAnnotations(locations)
    }
    
    func regionForAnnotations(annotations: [MKAnnotation]) -> MKCoordinateRegion {
        var region: MKCoordinateRegion
        switch annotations.count {
        case 0:
            region = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 1000, 1000)
        case 1:
            let annotation = annotations[annotations.count - 1]
            region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 1000, 1000)
        default:
            var topLeftCoord = CLLocationCoordinate2D(latitude: -90, longitude: 180)
            var bottomRightCoord = CLLocationCoordinate2D(latitude: 90, longitude: -180)
            
            for annotation in annotations {
                topLeftCoord.latitude = max(topLeftCoord.latitude, annotation.coordinate.latitude)
                topLeftCoord.longitude = min(topLeftCoord.longitude, annotation.coordinate.longitude)
                bottomRightCoord.latitude = min(bottomRightCoord.latitude, annotation.coordinate.latitude)
                bottomRightCoord.longitude = max(bottomRightCoord.longitude, annotation.coordinate.longitude)
            }
            let center = CLLocationCoordinate2D(latitude: topLeftCoord.latitude - (topLeftCoord.latitude - topLeftCoord.latitude) / 2, longitude: topLeftCoord.longitude - (topLeftCoord.longitude - bottomRightCoord.longitude) / 2)
            
            let extraSpace = 1.1
            let span = MKCoordinateSpan(latitudeDelta: abs(topLeftCoord.latitude - bottomRightCoord.latitude) * extraSpace, longitudeDelta: abs(topLeftCoord.longitude - bottomRightCoord.longitude) * extraSpace)
            region = MKCoordinateRegion(center: center, span: span)
        }
        return mapView.regionThatFits(region)
    }
}

extension MapViewController: MKMapViewDelegate {
    
}
