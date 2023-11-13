import Foundation

/**
 The `TaskPersistence` protocol defines the methods for saving and retrieving tasks.

 */
protocol TaskPersistence {
    /**
     Saves the provided tasks.

     - Parameters:
         - tasks: An array of tasks to be saved.
     */
    func saveTasks(_ tasks: [Task])
    
    /**
     Retrieves the saved tasks.

     - Returns: An array of tasks retrieved from the persistence layer.
     */
    func retrieveTasks() -> [Task]
}

/**
 The `UserDefaultsTaskPersistence` class is a concrete implementation of the `TaskPersistence` protocol.
 It uses `UserDefaults` as the persistence layer to save and retrieve tasks.

 */
class UserDefaultsTaskPersistence: TaskPersistence {
    
    private let tasksKey = "tasks"
    
    func saveTasks(_ tasks: [Task]) {
        let data = tasks.map { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(data, forKey: tasksKey)
    }
    
    func retrieveTasks() -> [Task] {
        guard let data = UserDefaults.standard.array(forKey: tasksKey) as? [Data] else {
            return []
        }
        
        let tasks = data.compactMap { try? JSONDecoder().decode(Task.self, from: $0) }
        return tasks
    }
}

/**
 The `MockTaskPersistence` class is a mock implementation of the `TaskPersistence` protocol.
 // I used it for writing Unit tests
 */
class MockTaskPersistence: TaskPersistence {
    
    var savedTasks: [Task] = []
    
    func saveTasks(_ tasks: [Task]) {
        savedTasks = tasks
    }
    
    func retrieveTasks() -> [Task] {
        return savedTasks
    }
}
