//
//  StringExtension.swift
//  stations
//
//  Created by  Svetlanov on 13.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import Foundation

public extension String {
    func containsStringIgnoreCase(text: String) -> Bool {
        if self.lowercaseString.containsString(text.lowercaseString) {
            return true
        } else {
            return false
        }
    }
}