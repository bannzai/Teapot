//
//  Executor.swift
//  Commander
//
//  Created by Yudai.Hirose on 2019/06/04.
//

import Foundation

public struct ExecutorInfo {
    let path: Path
    let command: Command
}

public protocol Executor {
    associatedtype Information
    func exec(information: Information) throws
}

public struct TeapotCommandExecutor: Executor {
    public init() {
        
    }
    public func exec(information: ExecutorInfo) throws {
        
    }
}
