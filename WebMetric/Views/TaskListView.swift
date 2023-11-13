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
            Picker("Filter", selection: $taskViewModel.selectedFilter) {
                Text("All").tag(TaskFilter.all)
                Text("Completed").tag(TaskFilter.completed)
                Text("Not Completed").tag(TaskFilter.notCompleted)
            }
            .pickerStyle(SegmentedPickerStyle())
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
