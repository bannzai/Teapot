//
//  Executor.swift
//  Commander
//
//  Created by Yudai.Hirose on 2019/06/04.
//

import Foundation
import SwiftShell

public struct ExecutorInformation {
    let path: Path
    let command: Command
}

public struct TeapotCommandExecutor: Executor {
    public init() {
        
    }
    public func exec(information: ExecutorInformation) throws {
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
    }
}
