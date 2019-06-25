import SwiftShell
import Yaml
import Ocha
import PathKit
import Commander
import Foundation


if let pwd = ProcessInfo.processInfo.environment["DEBUG_PWD"] {
    SwiftShell.main.currentdirectory = pwd
}
let currentWorkingDirectory = SwiftShell.main.currentdirectory

let runner = command { (filePath: String) in
    do {
        let config = try YamlConfigReader().read(filePath: filePath)
        let infos = ConfigurationTranslator(
            extractor: FilePathExtractor(),
            sourcePathCollector: FilePathCollector(baseFilePath: currentWorkingDirectory, accessor: \.sourcePaths),
            ignorePathCollector: FilePathCollector(baseFilePath: currentWorkingDirectory, accessor: \.ignoredPaths)
            )
            .translate(config: config)
        try infos.forEach { try TeapotCommandExecutor().exec(information: $0) }
    } catch {
        print("[ERROR]🚫: " + error.localizedDescription)
    }
}

runner.run()
