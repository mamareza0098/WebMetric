//Created for WebMetric in 2023
// Using Swift 5.0

import SwiftUI

/**
 The `TaskRowView` is a SwiftUI view that represents a single task row in the task list.
 It displays the task title, description, and a button to toggle the task's completion status.

 - Parameters:
     - task: The task object to display in the row.
 */
struct TaskRowView: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    var task: Task
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                Text(task.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: {
                taskViewModel.toggleTaskCompletion(task: task) { isToggled in
                    return
                }
            }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .gray)
            }
        }
    }
}
