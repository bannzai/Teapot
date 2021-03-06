//
//  ConfigReader.swift
//  Commander
//
//  Created by Yudai Hirose on 2019/06/26.
//

import Foundation

public protocol ConfigReader {
    func read(filePath: Path) throws -> Config
}

