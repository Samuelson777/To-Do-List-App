import Foundation

func main() {
    let dataController = DataController()
    var shouldContinue = true

    while shouldContinue {
        print("\n1. Add Task")
        print("2. List Tasks")
        print("3. Complete Task")
        print("4. Delete Task")
        print("5. Search Tasks")
        print("6. Exit")
        print("Choose an option: ", terminator: "")

        if let input = readLine(), let choice = Int(input) {
            switch choice {
            case 1:
                print("Enter task title: ", terminator: "")
                if let title = readLine() {
                    print("Select priority (0: Low, 1: Medium, 2: High): ", terminator: "")
                    if let priorityInput = readLine(), let priorityIndex = Int(priorityInput), priorityIndex >= 0, priorityIndex < TaskPriority.allCases.count {
                        let priority = TaskPriority.allCases[priorityIndex]
                        print("Enter due date (yyyy-MM-dd) or leave blank: ", terminator: "")
                        if let dueDateInput = readLine(), !dueDateInput.isEmpty {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            if let dueDate = dateFormatter.date(from: dueDateInput) {
                                dataController.addTask(title: title, priority: priority, dueDate: dueDate)
                            } else {
                                print("Invalid date format.")
                            }
                        } else {
                            dataController.addTask(title: title, priority: priority, dueDate: nil)
                        }
                    } else {
                        print("Invalid priority selection.")
                    }
                }
            case 2:
                print("Tasks:")
                for (index, task) in dataController.tasks.enumerated() {
                    let status = task.isCompleted ? "✓" : "✗"
                    let dueDateString = task.dueDate != nil ? DateFormatter.localizedString(from: task.dueDate!, dateStyle: .short, timeStyle: .none) : "No due date"
                    print("\(index + 1). [\(status)] \(task.title) - Priority: \(task.priority.rawValue), Due: \(dueDateString)")
                }
            case 3:
                print("Enter task number to complete: ", terminator: "")
                if let input = readLine(), let taskIndex = Int(input), taskIndex > 0, taskIndex <= dataController.tasks.count {
                    dataController.completeTask(at: taskIndex - 1)
                } else {
                    print("Invalid task number.")
                }
            case 4:
                print("Enter task number to delete: ", terminator: "")
                if let input = readLine(), let taskIndex = Int(input), taskIndex > 0, taskIndex <= dataController.tasks.count {
                    dataController.deleteTask(at: taskIndex - 1)
                } else {
                    print("Invalid task number.")
                }
            case 5:
                print("Enter search term: ", terminator: "")
                if let searchTerm = readLine() {
                    let filteredTasks = dataController.tasks.filter { $0.title.contains(searchTerm) }
                    print("Search Results:")
                    for (index, task) in filteredTasks.enumerated() {
                        let status = task.isCompleted ? "✓" : "✗"
                        let dueDateString = task.dueDate != nil ? DateFormatter.localizedString(from: task.dueDate!, dateStyle: .short, timeStyle: .none) : "No due date"
                        print("\(index + 1). [\(status)] \(task.title) - Priority: \(task.priority.rawValue), Due: \(dueDateString)")
                    }
                }
            case 6:
                shouldContinue = false
            default:
                print("Invalid option. Please try again.")
            }
        }
    }
}

main()