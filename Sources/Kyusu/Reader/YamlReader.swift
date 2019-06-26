//
//  YamlReader.swift
//  Commander
//
//  Created by Yudai.Hirose on 2019/06/04.
//

import Foundation
import Yaml

public struct Config {
    public let sourcePaths: [Path]
    public let ignoredPaths: [Path]
    public let command: Command
}

public struct YamlConfigReader: ConfigReader {
    public init() {
        
    }
    public func read(filePath: Path) throws -> Config {
        return try parse(yaml: try load(filePath: filePath))
    }
}

let teapotYamlFileName = "teapot.yml"
private extension YamlConfigReader {
    func load(filePath: Path) throws -> Yaml {
        let path = URL(fileURLWithPath: filePath)
        let content = try String(contentsOf: path)
        let yaml = try Yaml.load(content)
        return yaml
    }
    
    func parse(yaml: Yaml) throws -> Config {
        guard
            let sources = yaml["source"].array,
            let ignores = yaml["ignore"].array,
            let execute = yaml["execute"].array
            else {
                throw YamlReadError.missingYamlFormat
        }
        
        return Config(
            sourcePaths: sources.compactMap { $0.string },
            ignoredPaths: ignores.compactMap { $0.string },
            command: execute.compactMap { $0.string }
        )
        
    }
}
