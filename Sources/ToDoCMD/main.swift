import Foundation

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

@MainActor func main() {
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
    
    switch command {
    case "add":
      if components.count > 1 {
        let title = components[1]
        taskManager.addTask(title: title)
        print("Task added.")
      } else {
        print("Please provide a task title.")
      }
    case "list":
      taskManager.listTasks()
    case "complete":
      if let id = Int(components[1]) {
        taskManager.markTaskAsCompleted(id: id)
        print("Task marked as completed.")
      } else {
        print("Please provide a valid task ID.")
      }
    case "remove":
      if let id = Int(components[1]) {
        taskManager.removeTask(id: id)
        print("Task removed.")
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

main()
