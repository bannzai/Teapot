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
    let commands: Commands
}

let markOfFile = "__FILE__"
public struct TeapotCommandExecutor: Executor {
    public init() {
        
    }
    public func exec(information: ExecutorInformation) throws {
        information.commands.forEach { shellCommand in
            let command: String
            switch shellCommand.contains(markOfFile) {
            case true:
                command = shellCommand.replacingOccurrences(of: markOfFile, with: information.path)
            case false:
                command = shellCommand
            }
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
}
