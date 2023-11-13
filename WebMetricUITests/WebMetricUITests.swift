//Created for WebMetric in 2023
// Using Swift 5.0

import XCTest

final class WebMetricUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    func testAddTask() throws {
        let taskTitle = "Test Task"
        let taskDescription = "This is a test task."
        
        app.buttons.firstMatch.tap()
        app.textFields.firstMatch.tap()
        app.textFields.firstMatch.typeText(taskTitle)
        app.textFields["Description"].tap()
        app.textFields["Description"].typeText(taskDescription)
        app.buttons["Add Task"].tap()
        
        XCTAssertTrue(app.staticTexts[taskTitle].exists)
        XCTAssertTrue(app.staticTexts[taskDescription].exists)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
