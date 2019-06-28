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

public protocol Runner {
    func run()
}

fileprivate let errorLogPrefix = "[ERROR]🚫: "
public class Start<T: Translator, E: Executor>: Runner where
    T.Input == Config, T.Output == [ExecutorInformation],
    E.Information == ExecutorInformation {

    public struct Dependency {
        let configurationTranslator: T
        let configReader: ConfigReader
        let executor: E
        let watcherType: Watcher.Type
        
        public init(
            configurationTranslator: T,
            configReader: ConfigReader,
            executor: E,
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
    
    // Keep watcher
    private var watcher: Watcher!

    public init(
        workingDirectory: String,
        dependency: Dependency
        ) {
        self.workingDirectory = workingDirectory
        self.dependency = dependency
    }
    
    public static func create() -> TeapotRunner {
        let currentWorkingDirectory: String
        switch ProcessInfo.processInfo.environment["DEBUG_PWD"] {
        case nil:
            currentWorkingDirectory = Process().currentDirectoryPath
        case let pwd?:
            currentWorkingDirectory = pwd
        }
        return TeapotRunner(
            workingDirectory: currentWorkingDirectory,
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

    public func run() {
        let config: Config
        do {
            config = try dependency.configReader.read(filePath: workingDirectory + teapotYamlFileName)
        } catch {
            print(errorLogPrefix + "Can not read yaml file. " + error.localizedDescription)
            exit(1)
        }
        
        let infos = dependency.configurationTranslator.translate(config: config)
        watcher = dependency.watcherType.create(paths: infos.map { $0.path })
        watcher.watch { [weak self] (events) in
            // FIXME: Watcher can not register throws keyword. Because Watcher.start call from Objective-C API.
            do {
                try infos
                    .filter { info in
                        events.map { $0.path }.contains(info.path)
                    }
                    .forEach { try self?.dependency.executor.exec(information: $0) }
            } catch {
                print(errorLogPrefix + error.localizedDescription)
            }
        }
    }
}

public typealias TeapotRunner = Start<ConfigurationTranslator<FilePathExtractor, FilePathCollector>, TeapotCommandExecutor>
