//
//  PoolTasks.swift
//  Exmo Console
//
//  Created by Semavin Artem on 18/09/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import Foundation
import Alamofire


final class TaskPool {
    
    static let instance = TaskPool() // singleton
    
    let session = SessionManager.default // default session
    
    var defaultHeaders: [String: String] { // default headers list
        return ["Content-Type": "application/json"]
    }
    
    private(set) var activeTasks = Set<DataTask>()
    
    // MARK: - Root
    
    private init() { } // forbid multi-instantiation
    
    // MARK: - Controls
    
    func send(task: DataTask, callback: DataTaskCallback?) {
        
        // check for existing task
        if taskById(task.taskId) != nil {
            print("task with id \"\(task.taskId)\" is already active.")
            return
        }
        
        // start
        activeTasks.insert(task)
        print("start task \"\(task.taskId)\". URL: \(task.urlRequest.urlRequest?.url!.absoluteString)")
        
        task.start { [unowned self] (task) in
            self.activeTasks.remove(task)
            print("task finished \"\(task.taskId)\". URL: \(task.urlRequest.urlRequest?.url!.absoluteString)")
            callback?(task)
        }
    }
    
    func send(taskId: String, request: URLRequestConvertible, callback: DataTaskCallback?) {
        let task = DataTask(taskId: taskId, request: request, session: session)
        send(task: task, callback: callback)
    }
    
    func taskById(_ taskId: String) -> DataTask? {
        return activeTasks.first(where: { (task) -> Bool in
            return task.taskId == taskId
        })
    }
}
