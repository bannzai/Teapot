//
//  Glob.swift
//  Commander
//
//  Created by Yudai.Hirose on 2019/06/12.
//

import Foundation
import Darwin

public func glob(_ pattern: String) -> [Path] {
    var gt = glob_t()
    let cPattern = strdup(pattern)
    defer {
        globfree(&gt)
        free(cPattern)
    }
    
    let flags = GLOB_TILDE | GLOB_BRACE | GLOB_MARK
    if Darwin.glob(cPattern, flags, nil, &gt) == 0 {
        let matchc = gt.gl_matchc
        return (0..<Int(matchc)).compactMap { index in
            if let path = String(validatingUTF8: gt.gl_pathv[index]!) {
                return path
            }
            
            return nil
        }
    }
    
    // GLOB_NOMATCH
    return []
}
