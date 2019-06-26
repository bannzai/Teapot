//
//  Executor.swift
//  Kyusu
//
//  Created by Yudai Hirose on 2019/06/26.
//

import Foundation

public protocol Extractor {
    associatedtype ExtractContentType
    
    func extract(sources: [ExtractContentType], ignores: [ExtractContentType]) -> [ExtractContentType]
}

