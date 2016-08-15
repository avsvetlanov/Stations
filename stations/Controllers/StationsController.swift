//
//  StationsController.swift
//  stations
//
//  Created by  Svetlanov on 13.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import Foundation

class StationsController {
    
    static let sharedInstance = StationsController()
    
    private let STATIONS_FILE_NAME : String = "allStations.json"
    
    private init() {
        loadStationsFromFile()
    }

    private var citiesContainer : CitiesContainer = CitiesContainer()
    private var sortedCountriesFrom : [String]?
    private var sortedCitiesFrom : [String:[City]]?
    private var sortedCountriesTo : [String]?
    private var sortedCitiesTo : [String:[City]]?
    
    private func loadStationsFromFile() {
        if let data = FilesUtils.readJsonDictionaryFromFile(STATIONS_FILE_NAME) {
            self.citiesContainer.parseDict(data)
        }
    }
    
    private func writeStationsToFile() {
        FilesUtils.writeJsonDictionaryToFile(STATIONS_FILE_NAME, dict: self.citiesContainer.writeDict())
    }
    
    func loadStationsFromServer(delegate: StationsRequestDelegate?) {
        let request = StationsApi().loadStations()
        request.setDelegate(StationsRequestDelegate(onStart: {
            delegate?.onStart()
            }, onFinish: { dict in
                self.citiesContainer.parseDict(dict)
                self.writeStationsToFile()
                delegate?.onFinish(dictResponse: dict)
            }, onError: { errorMessage in
                delegate?.onError(message: errorMessage)
        }))
        
        request.execute()
    }
    
    
    func getCities(directionType : CitiesDirectionType) -> [City] {
        switch directionType {
        case .FROM:
            return citiesContainer.citiesFrom
        case .TO:
            return citiesContainer.citiesTo
        }
    }
    
    func findStationsByText(cities: [City], text: String) -> [City] {
        var result = [City]()
        
        for city in cities {
            if city.countryTitle.containsStringIgnoreCase(text) ||
                city.districtTitle.containsStringIgnoreCase(text) ||
                city.cityTitle.containsStringIgnoreCase(text) ||
                city.regionTitle.containsStringIgnoreCase(text) {
                    result.append(city)
                    continue
            }
            
            let tempCity = City(copy: city)
            tempCity.stations.removeAll()
            
            for station in city.stations {
                if station.countryTitle.containsStringIgnoreCase(text) ||
                    station.districtTitle.containsStringIgnoreCase(text) ||
                    station.cityTitle.containsStringIgnoreCase(text) ||
                    station.regionTitle.containsStringIgnoreCase(text) ||
                    station.stationTitle.containsStringIgnoreCase(text) {
                        tempCity.stations.append(station)
                }
            }
            
            
            if tempCity.stations.count != 0 {
                result.append(tempCity)
            }
        }
        
        return result
    }
}