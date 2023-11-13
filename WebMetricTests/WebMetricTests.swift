//Created for WebMetric in 2023
// Using Swift 5.0

import XCTest
@testable import WebMetric

final class WebMetricTests: XCTestCase {

    var taskViewModel: TaskViewModel!

    override func setUpWithError() throws {
        taskViewModel = TaskViewModel(taskPersistence: MockTaskPersistence())
    }

    override func tearDownWithError() throws {
        taskViewModel = nil
        super.tearDown()
    }

    func testAddTask() {
        // Given
        let initialTaskCount = taskViewModel.tasks.count
        let title = "Test Task"
        let description = "This is a test task."
        
        // When
        taskViewModel.addTask(title: title, description: description)
        
        // Then
        XCTAssertEqual(taskViewModel.tasks.count, initialTaskCount + 1)
        let addedTask = taskViewModel.tasks.last
        XCTAssertEqual(addedTask?.title, title)
        XCTAssertEqual(addedTask?.description, description)
    }
    
    func testToggleTaskCompletion() {
        // Given
        let task = Task(title: "Test Task", description: "This is a test task.")
        taskViewModel.tasks = [task]
        
        // When
        taskViewModel.toggleTaskCompletion(task: task) { isToggled in
            // Then
            XCTAssertTrue(isToggled)
        }
    }
    
    func testFilterTasks() {
        // Given
        let task1 = Task(title: "Task 1", description: "This is task 1.")
        let task2 = Task(title: "Task 2", description: "This is task 2.")
        let task3 = Task(title: "Task 3", description: "This is task 3.")
        taskViewModel.tasks = [task1, task2, task3]
        
        // When
        taskViewModel.filterCompletedTasks = true
        
        // Then
        XCTAssertEqual(taskViewModel.filterTasks().count, 0)
        
        // When
        taskViewModel.filterCompletedTasks = false
        
        // Then
        XCTAssertEqual(taskViewModel.filterTasks().count, 3)
    }
    
    func testMoveTask() {
        // Given
        let task1 = Task(title: "Task 1", description: "This is task 1.")
        let task2 = Task(title: "Task 2", description: "This is task 2.")
        let task3 = Task(title: "Task 3", description: "This is task 3.")
        taskViewModel.tasks = [task1, task2, task3]
        
        // When
        taskViewModel.moveTask(from: IndexSet(integer: 0), to: 3) { movedTasks in
            // Then
            XCTAssertEqual(movedTasks[0].title, "Task 2")
            XCTAssertEqual(movedTasks[1].title, "Task 3")
            XCTAssertEqual(movedTasks[2].title, "Task 1")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
