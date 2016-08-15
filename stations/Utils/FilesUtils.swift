//
//  FilesUtils.swift
//  stations
//
//  Created by  Svetlanov on 13.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import Foundation

class FilesUtils {
    
    class func readJsonDictionaryFromFile(fileName : String) -> NSDictionary? {
        if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: ""), let data = NSData(contentsOfFile: path) {
            do {
                if let jsonDict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary {
                    return jsonDict
                } else {
                   Log.e("Error during converting JSON to NSDictionary")
                }
            } catch {
                Log.e("Error during JSON serialization: \(error)")
            }
        } else {
            Log.e("Error reading JSON from file")
        }
        
        return nil
    }

    
    class func writeJsonDictionaryToFile(fileName : String, dict: NSDictionary) {
        if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: ""), let file: NSFileHandle = NSFileHandle(forWritingAtPath: path) {
            do {
                let data = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions())
                file.truncateFileAtOffset(0)
                file.writeData(data)
                file.closeFile()
            } catch {
                Log.e("Error during JSON serialization: \(error)")
            }
        } else {
            Log.e("Error opening file")
        }
    }
}