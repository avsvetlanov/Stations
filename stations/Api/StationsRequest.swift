//
//  StationsRequest.swift
//  stations
//
//  Created by  Svetlanov on 13.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import Foundation

class StationsRequest {
    
    var method : RequestMethod!
    var delegate : StationsRequestDelegate?
    
    init(method: RequestMethod) {
        self.method = method
    }
    
    func setDelegate(delegate: StationsRequestDelegate) {
        self.delegate = delegate
    }
    
    
    
    func execute() {
        Log.d("Executing request to: \(self.method.getUrl())")
        delegate?.onStart()
        
        if self.method.getUrl() == nil {
            Log.e("Url is nil")
            delegate?.onError(message: "Неверная ссылка")
            return
        }
        
        let request = NSMutableURLRequest(URL: self.method.getUrl()!)
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        request.timeoutInterval = 15
        
        switch self.method.getMethodType() {
        case .GET:
            request.HTTPMethod = "GET"
        case .POST:
            request.HTTPMethod = "POST"
        }
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            guard error == nil else {
                Log.e("Connection error: \(error?.localizedDescription)")
                self.delegate?.onError(message: "Ошибка подключения: \(error!.localizedDescription)")
                return
            }
            
            guard data != nil else {
                Log.e("Recieved data is nil")
                self.delegate?.onError(message: "Не получен ответ от сервера")
                return
            }
            
            do {
                let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                if dict == nil {
                    Log.e("Could not cast JSON to NSDictionary")
                    self.delegate?.onError(message: "Ошибка обработки полученных данных")
                }
                
                Log.d("Request was executed successfully")
                self.delegate?.onFinish(dictResponse: dict!)
            } catch {
                Log.e("Could not parse response data: \(error)")
                self.delegate?.onError(message: "Ошибка обработки полученных данных")
            }
        })
        
        task.resume()
    }
}
