//
//  Translator.swift
//  Commander
//
//  Created by Yudai Hirose on 2019/06/26.
//

import Foundation

public protocol Translator {
    associatedtype Input
    associatedtype Output
    func translate(config: Input) -> Output
}
