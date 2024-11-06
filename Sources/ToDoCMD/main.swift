//
//  main.swift
//  ToDoCMD
//
//  Created by Ashesh Patel on 2024-11-05.
//
let taskManager = TaskManager()

func showHelp() {
  print("""
    Available commands:
    - add <task>        : Add a new task
    - list              : List all tasks
    - complete <id>     : Mark task as completed
    - remove <id>       : Remove task by ID
    - help              : Show available commands
    - exit              : Exit the app
    """)
}

@available(iOS 13.0, *)
func main() {
  print("Welcome to the To-Do CLI App!")
  showHelp()
  
  while true {
    print("\nEnter a command: ", terminator: "")
    
    guard let input = readLine() else {
      print("Invalid input.")
      continue
    }
    
    let components = input.split(separator: " ", maxSplits: 1).map { String($0) }
    let command = components.first ?? ""
    
    Task {
      switch command {
      case "add":
        if components.count > 1 {
          await taskManager.addTask(title: components[1])  // Pass only the title here
        } else {
          print("Please provide a task title.")
        }
      case "list":
        await taskManager.listTasks()
      case "complete":
        if components.count > 1, let id = Int(components[1]) {
          await taskManager.markTaskAsCompleted(id: id)
        } else {
          print("Please provide a valid task ID.")
        }
      case "remove":
        if components.count > 1, let id = Int(components[1]) {
          await taskManager.removeTask(id: id)
        } else {
          print("Please provide a valid task ID.")
        }
      case "help":
        showHelp()
      case "exit":
        print("Exiting the app.")
        return
      default:
        print("Unknown command. Type 'help' to see available commands.")
      }
    }
  }
}

if #available(iOS 13.0, *) {
  main()
} else {
  // Fallback on earlier versions
}
