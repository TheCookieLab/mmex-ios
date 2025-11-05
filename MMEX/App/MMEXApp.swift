import OSLog
import SwiftUI
import AmplitudeSwift

let log = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: "mmex.log"
)

@main
struct MMEXApp: App {
    @StateObject private var pref = Preference()
    @StateObject private var vm = ViewModel(withStoredDatabase: ())

    private let amplitude: Amplitude = {
        let config = Configuration(
            apiKey: "1e1fbc10354400d9c3392a89558d693d",
            autocapture: [
                .sessions,
                .appLifecycles
            ]
        )
        return Amplitude(configuration: config)
    }()

    func track(pref: Preference) {
        log.debug("DEBUG: MMEXApp.track()")
        if pref.track.userId.isEmpty {
            pref.track.userId = String(format: "ios_%@", TimestampString(Date()).string)
        }

        if pref.track.sendUsage == .boolTrue {
            amplitude.setUserId(userId: pref.track.userId)
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    pref.theme.appearance.apply()
                    track(pref: pref)
                }
                .environmentObject(pref)
                .environmentObject(vm)
        }
    }
}
