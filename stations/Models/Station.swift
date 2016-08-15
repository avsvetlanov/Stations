//
//  Station.swift
//  stations
//
//  Created by  Svetlanov on 13.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import Foundation

class Station : AbstractObject {
    var countryTitle : String = ""
    var point : LocationPoint?
    var districtTitle : String = ""
    var cityId : Int = -1
    var cityTitle : String = ""
    var regionTitle : String = ""
    
    var stationId : Int = -1
    var stationTitle : String = ""
    
    required init() {}
    
    required init(copy: Station) {
        self.countryTitle = copy.countryTitle
        if let point = copy.point {
            self.point = LocationPoint(copy: point)
        }
        self.districtTitle = copy.districtTitle
        self.cityId = copy.cityId
        self.cityTitle = copy.cityTitle
        self.regionTitle = copy.regionTitle
        self.stationId = copy.stationId
        self.stationTitle = copy.stationTitle
    }
    
    required init(dict: NSDictionary) {
        parseDict(dict)
    }
    
    func parseDict(dict: NSDictionary) {
        self.countryTitle = dict.objectForKey("countryTitle") as? String ?? ""
        
        if let pointDictionary = dict.objectForKey("point") as? NSDictionary {
            self.point = LocationPoint(dict: pointDictionary)
        } else {
            self.point = nil
        }
        
        self.districtTitle = dict.objectForKey("districtTitle") as? String ?? ""
        self.cityId = dict.objectForKey("cityId") as? Int ?? -1
        self.cityTitle = dict.objectForKey("cityTitle") as? String ?? ""
        self.regionTitle = dict.objectForKey("regionTitle") as? String ?? ""
        self.stationId = dict.objectForKey("stationId") as? Int ?? -1
        self.stationTitle = dict.objectForKey("stationTitle") as? String ?? ""
    }
    
    
    func writeDict() -> NSDictionary {
        let result = NSMutableDictionary()
        result.setObject(countryTitle, forKey: "countryTitle")
        if point != nil {
            result.setObject(point!.writeDict(), forKey: "point")
        }
        result.setObject(districtTitle, forKey: "districtTitle")
        result.setObject(cityId, forKey: "cityId")
        result.setObject(cityTitle, forKey: "cityTitle")
        result.setObject(regionTitle, forKey: "regionTitle")
        result.setObject(stationId, forKey: "stationId")
        result.setObject(stationTitle, forKey: "stationTitle")
        return result
    }
//    func toString() -> String {
//        return "Station{" +
//            "countryTitle = \(countryTitle)" +
//            ",point = \(point?.toString())" +
//            ",districtTitle = \(districtTitle)" +
//            ",cityId = \(cityId)" +
//            ",cityTitle = \(cityTitle)" +
//            ",regionTitle = \(regionTitle)" +
//            ",stationId = \(stationId)" +
//            ",stationTitle = \(stationId)" +
//            "}"
//    }
}