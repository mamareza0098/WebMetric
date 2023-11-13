//Created for WebMetric in 2023
// Using Swift 5.0

import SwiftUI

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
