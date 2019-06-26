//
//  Executor.swift
//  Kyusu
//
//  Created by Yudai Hirose on 2019/06/26.
//

import Foundation

public protocol Executor {
    func exec(information: ExecutorInformation) throws
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
