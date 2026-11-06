import SwiftUI

@main
struct SchoolApp_SESEIU23001App: App {
    @StateObject private var repository = SchoolRepository()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(repository)
        }
    }
}
