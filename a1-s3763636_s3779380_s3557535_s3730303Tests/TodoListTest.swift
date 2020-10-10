//
//  TodoListTest.swift
//  a1-s3763636_s3779380_s3557535_s3730303Tests
//
//  Created by David Manolitsas on 8/10/20.
//  Copyright © 2020 David Manolitsas. All rights reserved.
//

import Foundation
import XCTest

@testable import a1_s3763636_s3779380_s3557535_s3730303
class TodoListTests: XCTestCase {
    
    private var viewModel = TodoViewModel()
    private var todoList:TodoList = TodoList.shared
    private var task1:Task?
    private var task2:Task?
    private var task3:Task?
    
    
    override func setUp() {
        super.setUp()
        task1 = Task(id: 1, description: "Go to the shops")
        task2 = Task(id: 2, description: "Walk the dog")
        task3 = Task(id: 3, description: "Wish mum happy birthday")
        
        viewModel.addTask(task: task1!)
        viewModel.addTask(task: task2!)
        viewModel.addTask(task: task3!)
        
    }
    
    override func tearDown() {
        super.tearDown()
        todoList.deleteCoreDataTask(taskID: 1)
        todoList.deleteCoreDataTask(taskID: 2)
        todoList.deleteCoreDataTask(taskID: 3)
    }
    
    // test adding tasks to the todo list
    func testAddingTask() {
        XCTAssertEqual(3, todoList.tasks.count)
        XCTAssertEqual("Go to the shops", todoList.tasks[0].description)
        XCTAssertEqual("Walk the dog", todoList.tasks[1].description)
    }
    
    // test sort tasks based priority and updating priority
    func testSortTasks() {
        
        viewModel.updatePriority(index: 0, priority: .low)
        
        XCTAssertEqual("Go to the shops", viewModel.getTask(byIndex: 0).description)
        XCTAssertEqual("Walk the dog", viewModel.getTask(byIndex: 1).description)
        XCTAssertEqual("Wish mum happy birthday", viewModel.getTask(byIndex: 2).description)
    }
    
    // test updating tasks priority
    func testUpdatingReminder() {
        
        let date = Date()
        
        viewModel.updateTaskReminder(index: 0, isOn: true)
        viewModel.updateReminderDate(index: 0, date: date)
        
        XCTAssertEqual(date, viewModel.getTask(byIndex: 0).reminder.date)
        
    }
    
   
}



