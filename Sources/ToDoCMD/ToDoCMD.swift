import Foundation
import SwiftUI

// Define the Task struct
public struct ToDoItem: Identifiable, Codable {
  public let id: Int
  let title: String
  var isCompleted: Bool
}

public class TaskManager {
  private(set) var tasks: [ToDoItem] = []
  private let fileURL: URL
  
  init() {
    // Define the file path for storing tasks
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    fileURL = documentsURL.appendingPathComponent("tasks.json")
    
    loadTasks()
  }
  
  func addTask(title: String) {
    let newTask = ToDoItem(id: tasks.count + 1, title: title, isCompleted: false)
    tasks.append(newTask)
    saveTasks()
  }
  
  func listTasks() {
    for task in tasks {
      print("\(task.id): \(task.title) [\(task.isCompleted ? "Completed" : "Pending")]")
    }
  }
  
  func markTaskAsCompleted(id: Int) {
    if let index = tasks.firstIndex(where: { $0.id == id }) {
      tasks[index].isCompleted = true
      saveTasks()
    } else {
      print("Task not found.")
    }
  }
  
  func removeTask(id: Int) {
    if let index = tasks.firstIndex(where: { $0.id == id }) {
      tasks.remove(at: index)
      saveTasks()
    } else {
      print("Task not found.")
    }
  }
  
  private func saveTasks() {
    do {
      let data = try JSONEncoder().encode(tasks)
      try data.write(to: fileURL)
    } catch {
      print("Failed to save tasks: \(error)")
    }
  }
  
  private func loadTasks() {
    do {
      let data = try Data(contentsOf: fileURL)
      tasks = try JSONDecoder().decode([ToDoItem].self, from: data)
    } catch {
      print("No previous tasks found or failed to load tasks.")
    }
  }
}
