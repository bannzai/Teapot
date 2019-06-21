import SwiftShell
import Yaml
import Ocha
import PathKit
import Commander


let main = command { (filePath: String) in
    print("filePath: \(filePath)")
    let config = try YamlReaderImpl().read(filePath: filePath)
    let infos = ConfigurationTranslatorImpl().translate(config: config)
    try infos.forEach { try ExecutorImpl().exec(information: $0) }
}

main.run()
