//
//  ConfigReader.swift
//  Commander
//
//  Created by Yudai Hirose on 2019/06/26.
//

import Foundation

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

