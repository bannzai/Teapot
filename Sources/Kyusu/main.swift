import SwiftShell
import Yaml
import Ocha
import PathKit
import Commander


let main = command { (filename: String) in
    print("Reading file \(filename)...")
}

main.run()
