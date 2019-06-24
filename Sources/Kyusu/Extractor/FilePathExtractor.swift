//
//  FilePathExtractor.swift
//  Commander
//
//  Created by Yudai.Hirose on 2019/06/24.
//

import Foundation

public struct ExtractorRule<T> {
    typealias Content = T
    
    private let rule: (T) -> Bool
    
    public init(rule: @escaping (T) -> Bool) {
        self.rule = rule
    }
    func canApply(content: T) -> Bool {
        return rule(content)
    }
    
    func apply(content: T) -> T? {
        return canApply(content: content) ? content : nil
    }
}

public protocol HasRule {
    associatedtype RuleContentType
    var rule: ExtractorRule<RuleContentType> { get }
}

public protocol Extractor {
    associatedtype ContentType

    func extract(content: [ContentType]) -> [ContentType]
}

extension Extractor where Self: HasRule, Self.RuleContentType == Self.ContentType {
    public func extract(content: [ContentType]) -> [ContentType] {
        return content.compactMap { rule.apply(content: $0) }
    }
}

public struct FilePathExtractor: Extractor, HasRule {
    public typealias ContentType = Path
    public var rule: ExtractorRule<Path>
    public init(rule: ExtractorRule<Path>) {
        self.rule = rule
    }
}
