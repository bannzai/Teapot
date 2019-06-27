import Foundation
import TeapotCore

func run() {
    let runner = Runner<Runner.DefaultTranslator>.create()
    runner.run()
    RunLoop.main.run()
}

run()
