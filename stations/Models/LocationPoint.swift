//
//  LocationPoint.swift
//  stations
//
//  Created by  Svetlanov on 13.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import Foundation

class LocationPoint : AbstractObject {
    var longitude : Double?
    var latitude : Double?
    
    required init() {}
    
    required init(copy: LocationPoint) {
        self.longitude = copy.longitude
        self.latitude = copy.latitude
    }
    
    required init(dict: NSDictionary) {
        parseDict(dict)
    }
    
    func parseDict(dict: NSDictionary) {
        self.longitude = dict.objectForKey("longitude") as? Double ?? nil
        self.latitude = dict.objectForKey("latitude") as? Double ?? nil
    }
    
    func writeDict() -> NSDictionary {
        let result = NSMutableDictionary()
        if let longitude = self.longitude {
            result.setObject(longitude, forKey: "longitude")
        }
        if let latitude = self.latitude {
            result.setObject(latitude, forKey: "latitude")
        }
        
        return result
    }
//
//    func toString() -> String {
//        return "LocationPoint{" +
//            "longitude = \(longitude)" +
//            "latitude = \(latitude)" +
//        "}"
//    }
}