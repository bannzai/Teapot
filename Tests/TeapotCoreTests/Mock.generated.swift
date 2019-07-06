// Generated using Sourcery 0.16.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

import TeapotCore














class CollectorMock: Collector {

    //MARK: - collect

    var collectInfoCallsCount = 0
    var collectInfoCalled: Bool {
        return collectInfoCallsCount > 0
    }
    var collectInfoReceivedInfo: CollectInformation?
    var collectInfoReceivedInvocations: [CollectInformation] = []
    var collectInfoReturnValue: [CollectContent]!
    var collectInfoClosure: ((CollectInformation) -> [CollectContent])?

    func collect(info: CollectInformation) -> [CollectContent] {
        collectInfoCallsCount += 1
        collectInfoReceivedInfo = info
        collectInfoReceivedInvocations.append(info)
        return collectInfoClosure.map({ $0(info) }) ?? collectInfoReturnValue
    }

}
class ConfigReaderMock: ConfigReader {

    //MARK: - read

    var readFilePathThrowableError: Error?
    var readFilePathCallsCount = 0
    var readFilePathCalled: Bool {
        return readFilePathCallsCount > 0
    }
    var readFilePathReceivedFilePath: Path?
    var readFilePathReceivedInvocations: [Path] = []
    var readFilePathReturnValue: Config!
    var readFilePathClosure: ((Path) throws -> Config)?

    func read(filePath: Path) throws -> Config {
        if let error = readFilePathThrowableError {
            throw error
        }
        readFilePathCallsCount += 1
        readFilePathReceivedFilePath = filePath
        readFilePathReceivedInvocations.append(filePath)
        return try readFilePathClosure.map({ try $0(filePath) }) ?? readFilePathReturnValue
    }

}
class ExecutorMock: Executor {

    //MARK: - exec

    var execInformationThrowableError: Error?
    var execInformationCallsCount = 0
    var execInformationCalled: Bool {
        return execInformationCallsCount > 0
    }
    var execInformationReceivedInformation: Information?
    var execInformationReceivedInvocations: [Information] = []
    var execInformationClosure: ((Information) throws -> Void)?

    func exec(information: Information) throws {
        if let error = execInformationThrowableError {
            throw error
        }
        execInformationCallsCount += 1
        execInformationReceivedInformation = information
        execInformationReceivedInvocations.append(information)
        try execInformationClosure?(information)
    }

}
class ExtractorMock: Extractor {

    //MARK: - extract

    var extractSourcesIgnoresCallsCount = 0
    var extractSourcesIgnoresCalled: Bool {
        return extractSourcesIgnoresCallsCount > 0
    }
    var extractSourcesIgnoresReceivedArguments: (sources: [ExtractContentType], ignores: [ExtractContentType])?
    var extractSourcesIgnoresReceivedInvocations: [(sources: [ExtractContentType], ignores: [ExtractContentType])] = []
    var extractSourcesIgnoresReturnValue: [ExtractContentType]!
    var extractSourcesIgnoresClosure: (([ExtractContentType], [ExtractContentType]) -> [ExtractContentType])?

    func extract(sources: [ExtractContentType], ignores: [ExtractContentType]) -> [ExtractContentType] {
        extractSourcesIgnoresCallsCount += 1
        extractSourcesIgnoresReceivedArguments = (sources: sources, ignores: ignores)
        extractSourcesIgnoresReceivedInvocations.append((sources: sources, ignores: ignores))
        return extractSourcesIgnoresClosure.map({ $0(sources, ignores) }) ?? extractSourcesIgnoresReturnValue
    }

}
class RunnerMock: Runner {

    //MARK: - run

    var runCallsCount = 0
    var runCalled: Bool {
        return runCallsCount > 0
    }
    var runClosure: (() -> Void)?

    func run() {
        runCallsCount += 1
        runClosure?()
    }

}
class TranslatorMock: Translator {

    //MARK: - translate

    var translateConfigCallsCount = 0
    var translateConfigCalled: Bool {
        return translateConfigCallsCount > 0
    }
    var translateConfigReceivedConfig: Input?
    var translateConfigReceivedInvocations: [Input] = []
    var translateConfigReturnValue: Output!
    var translateConfigClosure: ((Input) -> Output)?

    func translate(config: Input) -> Output {
        translateConfigCallsCount += 1
        translateConfigReceivedConfig = config
        translateConfigReceivedInvocations.append(config)
        return translateConfigClosure.map({ $0(config) }) ?? translateConfigReturnValue
    }

}
class WatcherMock: Watcher {

    //MARK: - create

    var createPathsCallsCount = 0
    var createPathsCalled: Bool {
        return createPathsCallsCount > 0
    }
    var createPathsReceivedPaths: [WatchingPathable]?
    var createPathsReceivedInvocations: [[WatchingPathable]] = []
    var createPathsReturnValue: Watcher!
    var createPathsClosure: (([WatchingPathable]) -> Watcher)?

    func create(paths: [WatchingPathable]) -> Watcher {
        createPathsCallsCount += 1
        createPathsReceivedPaths = paths
        createPathsReceivedInvocations.append(paths)
        return createPathsClosure.map({ $0(paths) }) ?? createPathsReturnValue
    }

    //MARK: - watch

    var watchCallsCount = 0
    var watchCalled: Bool {
        return watchCallsCount > 0
    }
    var watchReceivedCallback: WatcherCallBack?
    var watchReceivedInvocations: [WatcherCallBack] = []
    var watchClosure: ((@escaping WatcherCallBack) -> Void)?

    func watch(_ callback: @escaping WatcherCallBack) {
        watchCallsCount += 1
        watchReceivedCallback = callback
        watchReceivedInvocations.append(callback)
        watchClosure?(callback)
    }

}
<Paste>
