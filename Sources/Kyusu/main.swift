import SwiftShell
import Yaml
import Ocha
import PathKit
import Commander


let main = command { (filePath: String) in
    print("filePath: \(filePath)")
    let config = try YamlConfigReader().read(filePath: filePath)
    print("config: \(config)")
    let infos = ConfigurationTranslator().translate(config: config)
    print("infos: \(infos)")
    try infos.forEach { try TeapotCommandExecutor().exec(information: $0) }
}

main.run()
