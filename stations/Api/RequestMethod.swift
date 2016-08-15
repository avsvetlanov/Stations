//
//  AbstractMethod.swift
//  stations
//
//  Created by  Svetlanov on 13.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import Foundation

enum HttpMethod {
    case GET
    case POST
}

protocol RequestMethod {
    
    func getMethodType() -> HttpMethod
    
    func getUrl() -> NSURL?
    
}
