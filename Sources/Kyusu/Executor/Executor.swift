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

public enum ExecutorError: Error {
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            return "Unexpected error from SwiftShell."
        }
    }
}

public struct TeapotCommandExecutor: Executor {
    public init() {
        
    }
    public func exec(information: ExecutorInfo) throws {
        let command = information.command.joined(separator: " ") + " \(information.path)"
        let output = main.run(bash: command)
        switch output.succeeded {
        case false:
            switch output.error {
            case .none:
                print("[ERROR]🚫: " + ExecutorError.unknown.localizedDescription)
                exit(1)
            case .some(let error):
                print("[ERROR]🚫: " + error.localizedDescription)
                exit(2)
            }
        case true:
            print(output.stdout)
        }
        print(main.run(bash: command).stdout) // TODO: changing filedescriptor
    }
}
