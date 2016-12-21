//
//  DataTask.swift
//  Exmo Console
//
//  Created by Semavin Artem on 18/09/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import Foundation
import Alamofire

typealias DataTaskCallback = (DataTask) -> ()

final class DataTask: Hashable, Equatable {
    
    let taskId: String
    let urlRequest: URLRequestConvertible
    
    private(set) var responseObject: Response?
    private(set) var error: Error?
    
    private(set) var isCompleted = false
    private(set) var isCancelled = false
    
    let session: SessionManager
    private var task: DataRequest?
    
    init(taskId: String, request: URLRequestConvertible, session: SessionManager = SessionManager.default) {
        self.taskId = taskId
        self.urlRequest = request
        self.session = session
    }
    
    // MARK: - Controls
    
    func start(callback: DataTaskCallback?){
        
        let request = session.request(urlRequest)
        
        if isCancelled{
            return
        }
        self.isCompleted = true
        
        request.validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    self.responseObject = Response(json: response.result.value)
                case .failure(let error):
                    self.error = error
                }
                
                callback?(self)
        }
    }
    
    func cancel(callback: DataTaskCallback?) {
        if task != nil && !isCompleted && !isCancelled {
            isCancelled = true
            task?.cancel()
            // callback
            callback?(self)
        }
    }
    
    // MARK: - Equatable
    
    static func ==(lhs: DataTask, rhs: DataTask) -> Bool {
        return lhs.taskId == rhs.taskId
    }
    
    // MARK: - Hashable
    
    var hashValue: Int {
        return taskId.hashValue
    }
    
}
