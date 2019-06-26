//
//  Watcher.swift
//  Commander
//
//  Created by Yudai Hirose on 2019/06/26.
//

import Foundation
import Ocha

public typealias WatcherCallBack = Ocha.Watcher.CallBack
public protocol Watcher {
    static func create(paths: [WatchingPathable]) -> Watcher
    func watch(_ callback: @escaping WatcherCallBack)
}

extension Ocha.Watcher: Watcher {
    public static func create(paths: [WatchingPathable]) -> Watcher {
        return Ocha.Watcher(paths: paths, isIgnoredDotPrefix: false)
    }
    public func watch(_ callback: @escaping WatcherCallBack) {
        start(callback)
    }
}
