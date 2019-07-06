//
//  Setup.swift
//  Commander
//
//  Created by Yudai Hirose on 2019/07/06.
//

import Foundation
import SwiftShell


public func setup() throws {
    let sources = main
        .run(bash: "ls -lA | awk -F ' ' '{print $9}'")
        .stdout
        .split(separator: "\n")
        .filter { !$0.isEmpty }
        .map { "- " + $0 }
        .joined(separator: "\n")
    let content = """
    ignore:
    - .git*
    source:
    \(sources)
    execute:
    - ls -la
    """
    
    let url = URL(fileURLWithPath: Process().currentDirectoryPath + "/" + teapotYamlFileName)
    try content.write(to: url, atomically: true, encoding: .utf8)
}
