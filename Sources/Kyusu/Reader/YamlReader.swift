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
    public let sourcePaths: [Path]
    public let ignoredPaths: [Path]
    public let command: Command
}

public protocol ConfigReader {
    associatedtype Config
    func read(filePath: Path) throws -> Config
}

public struct YamlConfigReader: ConfigReader {
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
private extension YamlConfigReader {
    func load(filePath: Path) throws -> Yaml {
        let path = URL(fileURLWithPath: filePath)
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
