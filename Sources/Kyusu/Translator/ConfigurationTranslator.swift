//
//  ConfigurationTranslator.swift
//  Commander
//
//  Created by Yudai.Hirose on 2019/06/04.
//

import Foundation

public protocol ConfigurationTranslator {
    func translate(config: YamlConfig) -> ExecutorInfo
}

public struct ConfigurationTranslatorImpl: ConfigurationTranslator {
    public func translate(config: YamlConfig) -> ExecutorInfo {
        fatalError()
    }
}
