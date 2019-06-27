//
//  Collector.swift
//  Commander
//
//  Created by Yudai Hirose on 2019/06/26.
//

import Foundation

public protocol Collector {
    associatedtype CollectContent
    associatedtype CollectInformation
    
    func collect(info: CollectInformation) -> [CollectContent]
}

