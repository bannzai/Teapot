import Foundation
import TeapotCore
import Commander

Group {
    $0.command("setup", {
        try setup()
    })
    $0.command("start", {
        print("🍵 Teapot start 🍵")
        let runner = TeapotRunner.create()
        runner.run()
        RunLoop.main.run()
    })
}
.run()

