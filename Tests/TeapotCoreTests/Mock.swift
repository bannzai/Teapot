import Foundation
import TeapotCore
import Ocha

class CollectorMock<CollectInformation, CollectContent>: Collector {
    
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
class ExecutorMock<Information>: Executor {

    
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
class ExtractorMock<ExtractContentType>: Extractor {
    
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
    
    func translate(config: Config) -> [ExecutorInformation] {
        translateConfigCallsCount += 1
        translateConfigReceivedConfig = config
        translateConfigReceivedInvocations.append(config)
        return translateConfigClosure.map({ $0(config) }) ?? translateConfigReturnValue
    }
    
}
class WatcherMock: WatcherType {
    static func create(paths: [WatchingPathable]) -> WatcherType {
        let instance = WatcherMock()
        instance.watchClosure = { callback in
            callback([Event(id: 1, flag: 1, path: "Sources/Teapot/main.swift")])
        }
        return instance
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
