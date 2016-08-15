//
//  CitiesContainer.swift
//  stations
//
//  Created by  Svetlanov on 13.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import Foundation

enum CitiesDirectionType {
    case FROM 
    case TO
    
    var description : String {
        get {
            switch(self) {
            case FROM:
                return "Откуда"
            case TO:
                return "Куда"
            }
        }
    }
}

class CitiesContainer : AbstractObject {
    
    var citiesFrom : [City] = []
    var citiesTo : [City] = []
    
    required init() {}
    
    required init(copy: CitiesContainer) {
        for city in copy.citiesFrom {
            citiesFrom.append(city)
        }
        for city in copy.citiesTo {
            citiesTo.append(city)
        }
    }
    
    required init(dict: NSDictionary) {
        parseDict(dict)
    }
    
    func parseDict(dict: NSDictionary) {
        citiesFrom = []
        if let citiesFromDictionaryArray = dict.objectForKey("citiesFrom") as? [NSDictionary] {
            for citiesFromDictionary in citiesFromDictionaryArray {
                let city = City(dict: citiesFromDictionary)
                self.citiesFrom.append(city)
            }
        }
        
        citiesTo = []
        if let citiesToDictionaryArray = dict.objectForKey("citiesTo") as? [NSDictionary] {
            for citiesToDictionary in citiesToDictionaryArray {
                let city = City(dict: citiesToDictionary)
                self.citiesTo.append(city)
            }
        }
    }
    
    func writeDict() -> NSDictionary {
        let result = NSMutableDictionary()
        
        var dictionaryArray = [NSDictionary]()
        for city in citiesFrom {
            dictionaryArray.append(city.writeDict())
        }
        result.setObject(dictionaryArray, forKey: "citiesFrom")
        
        dictionaryArray = [NSDictionary]()
        for city in citiesTo {
            dictionaryArray.append(city.writeDict())
        }
        result.setObject(dictionaryArray, forKey: "citiesTo")
        
        
        return result
    }
    
//    func toString() -> String {
//        var result = "CitiesContainer{"
//        if citiesFrom.count > 0 {
//            for city in citiesFrom {
//                result += city.toString() + ","
//            }
//            result.removeAtIndex(result.endIndex.predecessor()) //removing last ","
//        }
//        if citiesTo.count > 0 {
//            for city in citiesTo {
//                result += city.toString() + ","
//            }
//            result.removeAtIndex(result.endIndex.predecessor()) //removing last ","
//        }
//        
//        return result + "}"
//    }
}