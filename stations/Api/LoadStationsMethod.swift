//
//  LoadStationsMethod.swift
//  stations
//
//  Created by  Svetlanov on 13.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import Foundation

class LoadStationsMethod : RequestMethod {
    
    func getMethodType() -> HttpMethod {
        return .GET
    }
    
    func getUrl() -> NSURL? {
        return NSURL(string: "https://github.com/tutu-ru/hire_ios-test/blob/master/allStations.json?raw=true")
    }

}