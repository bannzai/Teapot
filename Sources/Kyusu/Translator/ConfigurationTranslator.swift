//
//  ConfigurationTranslator.swift
//  Commander
//
//  Created by Yudai.Hirose on 2019/06/04.
//

import Foundation

public protocol Translator {
    associatedtype Input
    associatedtype Output
    func translate(config: Input) -> Output
}

public struct ConfigurationTranslator<E: Extractor> {
    private let extractor: E
    public init(extractor: E) {
        self.extractor = extractor
    }
}

extension ConfigurationTranslator: Translator where E.ContentType == Path {
    public func translate(config: YamlConfig) -> [ExecutorInfo] {
        return extractor
            .extract(content: config.sourcePaths)
            .map { ExecutorInfo(path: $0, command: config.command) }
    }
}
