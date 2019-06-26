//
//  Executor.swift
//  Kyusu
//
//  Created by Yudai Hirose on 2019/06/26.
//

import Foundation

public protocol Executor {
    associatedtype Information
    func exec(information: Information) throws
}

public enum ExecutorError: Error {
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            return "Unexpected error from SwiftShell."
        }
    }
}
