//
//  FilePathCollector.swift
//  Commander
//
//  Created by Yudai.Hirose on 2019/06/25.
//

import Foundation

public struct FilePathCollector: Collector {
    let baseFilePath: Path
    let accessor: KeyPath<YamlConfig, [Path]>
    
    public init(
        baseFilePath: Path,
        accessor: KeyPath<YamlConfig, [Path]>
        ) {
        self.baseFilePath = baseFilePath
        self.accessor = accessor
    }
    
    public func collect(info: YamlConfig) -> [Path] {
        return info[keyPath: accessor].flatMap { path -> [Path] in
            let shouldGlob = path.contains("*")
            return shouldGlob ? Glob.glob(basePath: baseFilePath, pattern: path) : [path]
        }
    }
}
