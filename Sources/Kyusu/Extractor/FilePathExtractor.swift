//
//  FilePathExtractor.swift
//  Commander
//
//  Created by Yudai.Hirose on 2019/06/24.
//

import Foundation

public protocol Extractor {
    associatedtype ExtractContentType

    func extract(sources: [ExtractContentType], ignores: [ExtractContentType]) -> [ExtractContentType]
}


public struct FilePathExtractor: Extractor {
    public typealias ExtractContentType = Path
    
    public init() { }
    
    public func extract(sources: [Path], ignores: [Path]) -> [Path] {
        return sources.filter { !ignores.contains($0) }
    }
}
