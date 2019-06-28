import Foundation
import TeapotCore
import Commander

Group {
    $0.command("setup", {
        print("setup")
    })
    $0.command("start", {
        let runner = TeapotRunner.create()
        runner.run()
        RunLoop.main.run()
    })
}
.run()

