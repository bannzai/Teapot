//
//  YamlReader.swift
//  Commander
//
//  Created by Yudai.Hirose on 2019/06/04.
//

import Foundation
import Yaml

public typealias Path = String
public typealias Command = [String]
public struct YamlConfig {
    let sourcePaths: [Path]
    let ignoredPaths: [Path]
    let command: Command
}

public protocol YamlReader {
    func read(filePath: Path) throws -> YamlConfig
}

public struct YamlReaderImpl: YamlReader {
    public init() {
        
    }
    public func read(filePath: Path) throws -> YamlConfig {
        return try parse(yaml: try load(filePath: filePath))
    }
}

public enum YamlReadError: Error {
    case missingYamlFormat
}

let teapotYamlFileName = "teapot.yml"
private extension YamlReaderImpl {
    func load(filePath: Path) throws -> Yaml {
        let path = URL(string: filePath)!
        let content = try String(contentsOf: path)
        let yaml = try Yaml.load(content)
        return yaml
    }
    
    func parse(yaml: Yaml) throws -> YamlConfig {
        guard
            let sources = yaml["source"].array,
            let ignores = yaml["ignore"].array,
            let execute = yaml["execute"].array
            else {
                throw YamlReadError.missingYamlFormat
        }
        
        return YamlConfig(
            sourcePaths: sources.compactMap { $0.string },
            ignoredPaths: ignores.compactMap { $0.string },
            command: execute.compactMap { $0.string }
        )
        
    }
}
