//Created for WebMetric in 2023
// Using Swift 5.0

import SwiftUI

@main
struct WebMetricApp: App {
    @StateObject private var taskViewModel = TaskViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TaskListView()
            }
            .environmentObject(taskViewModel)
        }
    }
}
