//
//  SetupTests.swift
//  TeapotTests
//
//  Created by Yudai Hirose on 2019/07/06.
//

import XCTest
@testable import TeapotCore

class SetupTests: XCTestCase {
    let pwd = "/Users/bannzai/development/Teapot"
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        TeapotRunner(
            workingDirectory: pwd
            dependency: TeapotRunner.Dependency(
                configurationTranslator: ConfigurationTranslator<FilePathExtractor, FilePathCollector>(
                    extractor: FilePathExtractor(),
                    sourcePathCollector: FilePathCollector(baseFilePath: currentWorkingDirectory, accessor: \.sourcePaths),
                    ignorePathCollector: FilePathCollector(baseFilePath: currentWorkingDirectory, accessor: \.ignoredPaths)
                ),
                configReader: YamlConfigReader(),
                executor: TeapotCommandExecutor(),
                watcherType: Ocha.Watcher.self
            )
        )
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
