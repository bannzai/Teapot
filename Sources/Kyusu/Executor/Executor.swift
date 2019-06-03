//
//  Executor.swift
//  Commander
//
//  Created by Yudai.Hirose on 2019/06/04.
//

import Foundation

public struct ExecutorInfo {
    public let path: Path
    public let command: Command
}

public protocol Executor {
    func exec(information: ExecutorInfo) throws
}

public struct ExecutorImpl: Executor {
    public func exec(information: ExecutorInfo) throws {
        
    }
}
