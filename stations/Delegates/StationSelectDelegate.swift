//
//  StationSelectDelegate.swift
//  stations
//
//  Created by  Svetlanov on 15.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import Foundation

protocol StationSelectDelegate {
    func didSelectStation(station: Station, direction: CitiesDirectionType)
}