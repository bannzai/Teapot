import SwiftShell
import Yaml
import Ocha
import PathKit
import Commander


let main = command { (filename: String) in
    let config = try YamlReaderImpl().read(filePath: filename)
    let infos = ConfigurationTranslatorImpl().translate(config: config)
    try infos.forEach { try ExecutorImpl().exec(information: $0) }
}

main.run()
