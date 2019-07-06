//
//  FilePathCollector.swift
//  Commander
//
//  Created by Yudai.Hirose on 2019/06/25.
//

import Foundation

public struct FilePathCollector: Collector {
    let baseFilePath: Path
    let accessor: KeyPath<Config, [Path]>
    
    public init(
        baseFilePath: Path,
        accessor: KeyPath<Config, [Path]>
        ) {
        self.baseFilePath = baseFilePath
        self.accessor = accessor
    }
    
    public func collect(info: Config) -> [Path] {
        return info[keyPath: accessor]
            .map { path -> Path in
                let isAbstractPath = path.hasPrefix("/")
                return isAbstractPath ? path : baseFilePath + "/" + path
            }
            .flatMap { path -> [Path] in
            let shouldGlob = path.contains("*")
            return shouldGlob ? Glob.glob(basePath: baseFilePath, pattern: path) : [path]
        }
    }
}
