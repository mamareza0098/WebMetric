//Created for WebMetric in 2023
// Using Swift 5.0

import SwiftUI

/**
 The `TaskListView` is a SwiftUI view that displays a list of tasks.
 It relies on the `TaskViewModel` to manage and provide task data.

 */
struct TaskListView: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    
    var body: some View {
        VStack {
            Toggle(isOn: $taskViewModel.filterCompletedTasks) {
                Text("Filter Completed Tasks")
            }
            .padding()
            
            List {
                ForEach(taskViewModel.filterTasks()) { task in
                    TaskRowView(task: task)
                }
                .onMove { fromOffsets,toOffset in
                    taskViewModel.moveTask(from: fromOffsets, to: toOffset) { movedTasks in
                        return
                    }
                }
            }
        }
        .navigationBarTitle("Tasks")
        .navigationBarItems(trailing: NavigationLink(destination: AddTaskView()) {
            Image(systemName: "plus")
        })
    }
}

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

/**
 The `AddTaskView` is a SwiftUI view that allows users to add new tasks.
 It relies on the `TaskViewModel` to handle task creation and persistence.
 */
struct AddTaskView: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var description: String = ""
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Description", text: $description)
            
            Button(action: {
                taskViewModel.addTask(title: title, description: description)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Add Task")
            }
        }
        .navigationBarTitle("Add Task")
    }
}
