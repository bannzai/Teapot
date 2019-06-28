import Foundation
import TeapotCore
import Commander

Group {
    $0.command("setup", {
        print("setup")
    })
    $0.command("start", {
        let runner = Runner<Runner.DefaultTranslator>.create()
        runner.run()
        RunLoop.main.run()
    })
}
.run()

