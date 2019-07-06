//
//  StartTests.swift
//  TeapotTests
//
//  Created by Yudai Hirose on 2019/07/06.
//

import XCTest
@testable import TeapotCore

class StartTests: XCTestCase {
    let pwd = "/Users/bannzai/development/Teapot"
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let translatedValue = ExecutorInformation(path: "Sources/Teapot/main.swift", commands: ["ls", "-la"])
        let translator = TranslatorMock()
        translator.translateConfigClosure = { _ in return [translatedValue] }

        let reader = ConfigReaderMock()
        reader.readFilePathClosure = { path in
            return Config(
                sourcePaths: ["Sources/Teapot/main.swift"],
                ignoredPaths: [".git"],
                commands: ["ls -la"]
            )
        }

        let expectation = self.expectation(description: #function)
        let executor = ExecutorMock<ExecutorInformation>()
        executor.execInformationClosure = { _ in
            expectation.fulfill()
        }

        let start = Start(
            workingDirectory: pwd,
            dependency: Start.Dependency(
                configurationTranslator: translator,
                configReader: reader,
                executor: executor,
                watcherType: WatcherMock.self
            )
        )
        
        start.run()
        wait(for: [expectation], timeout: 0.1)
        
        XCTAssertEqual(executor.execInformationReceivedInformation?.commands, translatedValue.commands)
        XCTAssertEqual(executor.execInformationReceivedInformation?.path, translatedValue.path)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
