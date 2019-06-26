import Foundation

func run() {
    let runner = Runner<Runner.DefaultTranslator>.create()
    runner.run()
    RunLoop.main.run()
}

run()
