//
//  Runner.swift
//  Commander
//
//  Created by Yudai Hirose on 2019/06/26.
//

import Foundation
import SwiftShell
import Yaml
import Ocha
import PathKit
import Commander

fileprivate let errorLogPrefix = "[ERROR]🚫: "
public struct Runner<T: Translator>
    where T.Input == Config, T.Output == [ExecutorInformation] {

    public struct Dependency {
        let configurationTranslator: T
        let configReader: ConfigReader
        let executor: Executor
        let watcherType: Watcher.Type
        
        public init(
            configurationTranslator: T,
            configReader: ConfigReader,
            executor: Executor,
            watcherType: Watcher.Type
            ) {
            self.configurationTranslator = configurationTranslator
            self.configReader = configReader
            self.executor = executor
            self.watcherType = watcherType
        }
    }

    private let workingDirectory: String
    private let dependency: Dependency

    public init(
        workingDirectory: String,
        dependency: Dependency
        ) {
        self.workingDirectory = workingDirectory
        self.dependency = dependency
    }
    
    public typealias DefaultTranslator = ConfigurationTranslator<FilePathExtractor, FilePathCollector>
    public static func create() -> Runner<DefaultTranslator> {
        let currentWorkingDirectory: String
        switch ProcessInfo.processInfo.environment["DEBUG_PWD"] {
        case nil:
            currentWorkingDirectory = Process().currentDirectoryPath
        case let pwd?:
            currentWorkingDirectory = pwd
        }
        return Runner<DefaultTranslator>(
            workingDirectory: currentWorkingDirectory,
            dependency: Runner<DefaultTranslator>.Dependency(
                configurationTranslator: DefaultTranslator(
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

    public func run() {

        let config: Config
        do {
            config = try dependency.configReader.read(filePath: teapotYamlFileName)
        } catch {
            print(errorLogPrefix + "Can not read yaml file. " + error.localizedDescription)
            exit(1)
        }
        
        let infos = dependency.configurationTranslator.translate(config: config)
        let watcher = dependency.watcherType.create(paths: infos.map { $0.path })
        watcher.watch { (events) in
            // FIXME: Watcher can not register throws keyword. Because Watcher.start call from Objective-C API.
            do {
                try infos.forEach { try self.dependency.executor.exec(information: $0) }
            } catch {
                print(errorLogPrefix + error.localizedDescription)
            }
        }
    }
}


public func run() {
    Runner<Runner.DefaultTranslator>.create().run()
    RunLoop.main.run()
}
