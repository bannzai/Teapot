import SwiftShell
import Yaml
import Ocha
import PathKit
import Commander
import Foundation


if let pwd = ProcessInfo.processInfo.environment["DEBUG_PWD"] {
    SwiftShell.main.currentdirectory = pwd
}
let errorLogPrefix = "[ERROR]🚫: "
let currentWorkingDirectory = SwiftShell.main.currentdirectory

let config: YamlConfig
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

RunLoop.main.run()
