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

public struct Runner<T: Translator>
    where T.Input == Config, T.Output == [ExecutorInformation] {
    public struct Dependency {
        private let configurationTranslator: T
        private let configReader: ConfigReader
        private let executor: Executor
        
        public init(
            configurationTranslator: T,
            configReader: ConfigReader,
            executor: Executor
            ) {
            self.configurationTranslator = configurationTranslator
            self.configReader = configReader
            self.executor = executor
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

    public func run() {
        if let pwd = ProcessInfo.processInfo.environment["DEBUG_PWD"] {
            SwiftShell.main.currentdirectory = pwd
        }
        let errorLogPrefix = "[ERROR]🚫: "
        let currentWorkingDirectory = SwiftShell.main.currentdirectory
        
        let config: Config
        do {
            config = try YamlConfigReader().read(filePath: teapotYamlFileName)
        } catch {
            print(errorLogPrefix + "Can not read yaml file. " + error.localizedDescription)
            exit(1)
        }
        
        let infos = ConfigurationTranslator(
            extractor: FilePathExtractor(),
            sourcePathCollector: FilePathCollector(baseFilePath: currentWorkingDirectory, accessor: \.sourcePaths),
            ignorePathCollector: FilePathCollector(baseFilePath: currentWorkingDirectory, accessor: \.ignoredPaths)
            )
            .translate(config: config)
        
        let watcher = Ocha.Watcher(paths: infos.map { $0.path })
        watcher.start { (events) in
            // FIXME: Watcher can not register throws keyword. Because Watcher.start call from Objective-C API.
            do {
                try infos.forEach { try TeapotCommandExecutor().exec(information: $0) }
            } catch {
                print(errorLogPrefix + error.localizedDescription)
            }
        }
    }
}
