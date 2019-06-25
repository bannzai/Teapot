//
//  FilePathCollector.swift
//  Commander
//
//  Created by Yudai.Hirose on 2019/06/25.
//

import Foundation

public protocol Collector {
    associatedtype CollectContent
    associatedtype CollectInformation
    
    func collect(info: CollectInformation) -> [CollectContent]
}

public struct FilePathCollector: Collector {
    let baseFilePath: Path
    let accessor: WritableKeyPath<YamlConfig, [Path]>
    
    public func collect(info: YamlConfig) -> [Path] {
        return info[keyPath: accessor].flatMap { path -> [Path] in
            let shouldGlob = path.contains("*")
            return shouldGlob ? Glob.glob(basePath: baseFilePath, pattern: path) : [path]
        }
    }
}
