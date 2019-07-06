//
//  Setup.swift
//  Commander
//
//  Created by Yudai Hirose on 2019/07/06.
//

import Foundation
import SwiftShell

public func setup() throws {
    
    let currentDirectory = FileManager.default.currentDirectoryPath
    let sources = try FileManager
        .default
        .contentsOfDirectory(atPath: currentDirectory)
        .filter { !$0.hasPrefix(".") }
        .reduce([String]()) { (result, url) in
            var isDirectory = ObjCBool(false)
            var yamlElement: Path = "- " + url
            if FileManager.default.fileExists(atPath: url, isDirectory: &isDirectory) {
                switch isDirectory.boolValue {
                case false:
                    break
                case true:
                    yamlElement +=  "/*"
                }
            }
            return result + [yamlElement]
        }
        .joined(separator: "\n")
    
    
    let content = """
    ignore:
    - .git*
    source:
    \(sources)
    execute:
    - ls -la
    """

    let url = URL(fileURLWithPath: currentDirectory + "/" + teapotYamlFileName)
    try content.write(to: url, atomically: true, encoding: .utf8)
}
