import Foundation

enum TaskPriority: String, CaseIterable, Codable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

struct Task: Identifiable, Codable {
    var id = UUID() // Unique identifier for each task
    var title: String
    var isCompleted: Bool
    var priority: TaskPriority
    var dueDate: Date?
}