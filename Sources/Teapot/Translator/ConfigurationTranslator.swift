//
//  ConfigurationTranslator.swift
//  Commander
//
//  Created by Yudai.Hirose on 2019/06/04.
//

import Foundation

public struct ConfigurationTranslator<E: Extractor, C: Collector> {
    private let extractor: E
    private let sourcePathCollector: C
    private let ignorePathCollector: C
    public init(extractor: E, sourcePathCollector: C, ignorePathCollector: C) {
        self.extractor = extractor
        self.sourcePathCollector = sourcePathCollector
        self.ignorePathCollector = ignorePathCollector
    }
}

extension ConfigurationTranslator: Translator where E.ExtractContentType == Path, C.CollectContent == E.ExtractContentType, C.CollectInformation == Config {
    public func translate(config: Config) -> [ExecutorInformation] {
        return extractor
            .extract(
                sources: sourcePathCollector.collect(info: config),
                ignores: ignorePathCollector.collect(info: config)
            )
            .map { ExecutorInformation(path: $0, command: config.command) }
    }
}
