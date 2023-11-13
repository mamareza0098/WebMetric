import Foundation


enum TaskFilter {
    case all
    case completed
    case notCompleted
}
/**
 The `TaskViewModel` class is responsible for managing tasks and their persistence.
 It is an observable object that holds an array of tasks and provides methods for adding, toggling completion, filtering, and moving tasks.

 - Parameters:
     - taskPersistence: An optional parameter representing the task persistence implementation. Default is `UserDefaultsTaskPersistence`.
 */
class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var filterCompletedTasks: Bool = false
    @Published var selectedFilter: TaskFilter = .all

    private let taskPersistence: TaskPersistence
    
    init(taskPersistence: TaskPersistence = UserDefaultsTaskPersistence()) {
        self.taskPersistence = taskPersistence
        self.tasks = taskPersistence.retrieveTasks()
    }
    
    func addTask(title: String, description: String) {
        let task = Task(title: title, description: description)
        tasks.append(task)
        taskPersistence.saveTasks(tasks)
    }
    
    func toggleTaskCompletion(task: Task, completion: (Bool) -> Void) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            taskPersistence.saveTasks(tasks)
            completion(tasks[index].isCompleted)
        }
    }
    
    func filterTasks() -> [Task] {
        switch selectedFilter {
        case .all:
            return tasks
        case .completed:
            return tasks.filter { $0.isCompleted }
        case .notCompleted:
            return tasks.filter { !$0.isCompleted }
        }
    }
    
    func moveTask(from source: IndexSet, to destination: Int,completion: ([Task]) -> Void) {
        tasks.move(fromOffsets: source, toOffset: destination)
        taskPersistence.saveTasks(tasks)
        completion(tasks)
    }
}
