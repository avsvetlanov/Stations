//
//  City.swift
//  stations
//
//  Created by  Svetlanov on 13.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import Foundation

class City : AbstractObject {
    var countryTitle : String = ""
    var point : LocationPoint?
    var districtTitle : String = ""
    var cityId : Int = -1
    var cityTitle : String = ""
    var regionTitle : String = ""
    var stations : [Station] = [Station]()
    
    required init() {}
   
    required init(copy: City) {
        self.countryTitle = copy.countryTitle
        if let point = copy.point {
            self.point = LocationPoint(copy: point)
        }
        self.districtTitle = copy.districtTitle
        self.cityId = copy.cityId
        self.cityTitle = copy.cityTitle
        self.regionTitle = copy.regionTitle
        
        for station in copy.stations {
            self.stations.append(Station(copy: station))
        }
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

        self.stations = []
        if let stationsDictionaryArray = dict.objectForKey("stations") as? [NSDictionary] {
            for stationDictionary in stationsDictionaryArray {
                let station = Station(dict: stationDictionary)
                self.stations.append(station)
            }
        }
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
        
        var dictionaryArray = [NSDictionary]()
        for station in stations {
            dictionaryArray.append(station.writeDict())
        }
        result.setObject(dictionaryArray, forKey: "stations")
        
        return result
    }
    
//    func toString() -> String {
//        var result =  "City{" +
//            "countryTitle = \(countryTitle)" +
//            ",point = \(point?.toString())" +
//            ",districtTitle = \(districtTitle)" +
//            ",cityId = \(cityId)" +
//            ",cityTitle = \(cityTitle)" +
//            ",regionTitle = \(regionTitle)"
//        if stations.count > 0 {
//            result += ",stations = {"
//            for station in stations {
//                result += station.toString() + ","
//            }
//            result.removeAtIndex(result.endIndex.predecessor()) //removing last ","
//            result += "}"
//        }
//        return result + "}"
//    }
}