//
//  StationsRequestDelegate.swift
//  stations
//
//  Created by  Svetlanov on 14.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import Foundation

class StationsRequestDelegate {
    var onStart : () -> ()
    var onFinish : (dictResponse: NSDictionary) -> ()
    var onError : (message: String) -> ()
    
    init(onStart : () -> (), onFinish : (dictResponse: NSDictionary) -> (), onError : (message: String) -> ()) {
        self.onStart = onStart
        self.onFinish = onFinish
        self.onError = onError
    }
}