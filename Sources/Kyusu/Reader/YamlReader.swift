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
    let sourcePaths: [Path]
    let ignoredPaths: [Path]
    let command: Command
}

public protocol YamlReader {
    func read(filePath: Path) throws -> YamlConfig
}

public struct YamlReaderImpl: YamlReader {
    public func read(filePath: Path) throws -> YamlConfig {
        fatalError()
    }
}
