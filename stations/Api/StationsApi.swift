//
//  StationsApi.swift
//  stations
//
//  Created by  Svetlanov on 13.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import Foundation

class StationsApi {
    
    func loadStations() -> StationsRequest {
        let method = LoadStationsMethod()
        let req = StationsRequest(method: method)
        return req
    }
    
}