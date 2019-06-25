//
//  Executor.swift
//  Commander
//
//  Created by Yudai.Hirose on 2019/06/04.
//

import Foundation
import SwiftShell

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
        let command = information.command.joined(separator: " ") + " \(information.path)"
        print(main.run(bash: command).stdout) // TODO: changing filedescriptor
    }
}
