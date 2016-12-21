//
//  Router.swift
//  Exmo Console
//
//  Created by Semavin Artem on 18/09/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import Foundation
import Alamofire


enum Router: URLRequestConvertible {
    case ticker
    
    static let baseURLString = Constants.baseURL
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let result: (path: String, parameters: Parameters) = {
            switch self {
            case .ticker:
                return ("/ticker", [:])
            }
        }()
        
        let url = try Router.baseURLString.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(result.path))
        
        return try URLEncoding.default.encode(urlRequest, with: result.parameters)
    }
}
