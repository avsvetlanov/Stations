//
//  AbstractObject.swift
//  stations
//
//  Created by  Svetlanov on 13.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import Foundation

protocol AbstractObject {
    
    init()
    init(copy: Self)
    init(dict: NSDictionary)

    func parseDict(dict: NSDictionary)
    func writeDict() -> NSDictionary
    //func toString() -> String
}
