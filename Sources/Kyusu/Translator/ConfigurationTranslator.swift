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

public struct ConfigurationTranslator: Translator {
    public init() {
        
    }
    public func translate(config: YamlConfig) -> [ExecutorInfo] {
        fatalError()
    }
}
