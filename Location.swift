//
//  Location.swift
//  MyLocations
//
//  Created by Sean Perez on 7/31/16.
//  Copyright © 2016 SeanPerez. All rights reserved.
//

import Foundation
import CoreData
import MapKit


class Location: NSManagedObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(latitude, longitude)
    }
    
    var title: String? {
        if locationDescription.isEmpty {
            return "(No Description)"
        } else {
            return locationDescription
        }
    }
    
    var subtitle: String? {
        return category
    }
    
    var hasPhoto: Bool {
        return photoID != nil
    }
    
    var photoPath: String {
        assert(photoID != nil, "No photo ID set")
        let filename = "Photo-\(photoID!.integerValue).jpeg"
        return (applicationDocumentsDirectory as NSString).stringByAppendingPathCompenent(filename)
    }

}
