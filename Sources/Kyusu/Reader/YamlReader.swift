//
//  YamlReader.swift
//  Commander
//
//  Created by Yudai.Hirose on 2019/06/04.
//

import Foundation

public typealias Path = String
public typealias Command = [String]
public struct YamlConfig {
    public let sourcePaths: [Path]
    public let ignoredPaths: [Path]
    public let command: Command
    
    public init(
        sourcePaths: [Path],
        ignoredPaths: [Path],
        command: Command
        ) {
        self.sourcePaths = sourcePaths
        self.ignoredPaths = ignoredPaths
        self.command = command
    }
}

public protocol YamlReader {
    func read(config: YamlConfig) throws
}

public struct YamlReaderImpl: YamlReader {
    public func read(config: YamlConfig) throws {
        
    }
}
