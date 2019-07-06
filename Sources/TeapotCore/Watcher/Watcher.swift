//
//  Watcher.swift
//  Commander
//
//  Created by Yudai Hirose on 2019/06/26.
//

import Foundation
import Ocha

public typealias WatcherCallBack = Ocha.Watcher.CallBack
public protocol WatcherType {
    static func create(paths: [WatchingPathable]) -> WatcherType
    func watch(_ callback: @escaping WatcherCallBack)
}

extension Ocha.Watcher: WatcherType {
    public static func create(paths: [WatchingPathable]) -> WatcherType {
        return Ocha.Watcher(paths: paths, isIgnoredDotPrefix: false)
    }
    public func watch(_ callback: @escaping WatcherCallBack) {
        start(callback)
    }
}
