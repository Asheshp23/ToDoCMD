import Foundation
import SwiftUI

// Define the Task struct
public struct ToDoItem: Identifiable {
  public let id: Int
  let title: String
  var isCompleted: Bool
}

// Define the TaskManager to manage tasks
@available(iOS 13.0.0, *)
public actor TaskManager {
  private var tasks: [ToDoItem] = []
  private var nextId: Int = 1
  
  func addTask(title: String) {
    let task = ToDoItem(id: nextId, title: title, isCompleted: false)
    tasks.append(task)
    nextId += 1
    print("Added task: \(title)")
  }
  
  func listTasks() {
    if tasks.isEmpty {
      print("No tasks available.")
    } else {
      print("Tasks:")
      for task in tasks {
        print("\(task.id): \(task.title) - \(task.isCompleted ? "Completed" : "Pending")")
      }
    }
  }
  
  func markTaskAsCompleted(id: Int) {
    if let index = tasks.firstIndex(where: { $0.id == id }) {
      tasks[index].isCompleted = true
      print("Task \(id) marked as completed.")
    } else {
      print("Task with ID \(id) not found.")
    }
  }
  
  func removeTask(id: Int) {
    if let index = tasks.firstIndex(where: { $0.id == id }) {
      let removedTask = tasks.remove(at: index)
      print("Removed task: \(removedTask.title)")
    } else {
      print("Task with ID \(id) not found.")
    }
  }
}
