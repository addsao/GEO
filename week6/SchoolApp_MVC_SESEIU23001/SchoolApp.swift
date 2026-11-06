import SwiftUI

@main
struct SchoolApp: App {
    @StateObject private var repository = SchoolRepository()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(repository)
        }
    }
}
