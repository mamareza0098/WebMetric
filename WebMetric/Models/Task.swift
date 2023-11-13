//Created for WebMetric in 2023
// Using Swift 5.0

import Foundation

/**
 The `Task` struct represents a task with a unique identifier, a title, a description, and a completion status.

 - Parameters:
     - id: A unique identifier for the task, automatically generated using `UUID`.
     - title: The title of the task.
     - description: The description of the task.
     - isCompleted: A boolean value indicating whether the task is completed or not. Default is `false`.
 */
struct Task: Identifiable, Codable {
    let id = UUID()
    var title: String
    var description: String
    var isCompleted: Bool = false
}

