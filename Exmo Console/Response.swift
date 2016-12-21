//
//  Responce.swift
//  Exmo Console
//
//  Created by Semavin Artem on 18/09/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import Foundation

final class ResponseError {
    let code: NSNumber?
    let message: String?
    
    // MARK: - Root
    
    init(json: Any?) {
        if json != nil {
            let obj = JSON(json as Any)
            
            code = obj["result"].number
            message = obj["error"].string
        }
        else {
            code = nil
            message = nil
        }
    }
}

final class Response {
    let data: Any?
    let code: NSNumber?
    let message: String?
    let error: ResponseError?
    
    var json: JSON? {
        return JSON(data as Any)
    }
    
    // MARK: - Root
    
    init?(json: Any?) {
        guard let jsonData = json else { return nil }
        let obj = JSON(jsonData)
        
        code = obj["result"].number
        message = obj["error"].string
        data = jsonData
        error = ResponseError(json: json)
    }
}
