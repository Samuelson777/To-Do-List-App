import Foundation

class DataController {
    var tasks: [Task] = []
    private let fileURL: URL

    init() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        fileURL = documentsURL.appendingPathComponent("tasks.json")
        loadTasks()
    }

    func addTask(title: String, priority: TaskPriority, dueDate: Date?) {
        let newTask = Task(title: title, isCompleted: false, priority: priority, dueDate: dueDate)
        tasks.append(newTask)
        saveTasks()
    }

    func completeTask(at index: Int) {
        tasks[index].isCompleted.toggle()
        saveTasks()
    }

    func deleteTask(at index: Int) {
        tasks.remove(at: index)
        saveTasks()
    }

    private func saveTasks() {
        do {
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: fileURL)
        } catch {
            print("Error saving tasks: \(error)")
        }
    }

    private func loadTasks() {
        do {
            let data = try Data(contentsOf: fileURL)
            tasks = try JSONDecoder().decode([Task].self, from: data)
        } catch {
            print("Error loading tasks: \(error)")
        }
    }
}