
enum Recurrence: CaseIterable, Hashable {
    case daily
    case weekly
    case monthly
    case custom(days: Int, weeks: Int, months: Int)
    
    var displayText: String {
        switch self {
        case .daily:
            return "Daily"
        case .weekly:
            return "Weekly"
        case .monthly:
            return "Monthly"
        case .custom:
            return "Custom"
        }
    }
    
    var displayResult: String {
        switch self {
        case .daily:
            return "Daily"
        case .weekly:
            return "Weekly"
        case .monthly:
            return "Monthly"
        case .custom(let days, let weeks, let months):
            var components: [String] = []
            if days > 0 {
                components.append("\(days) day\(days > 1 ? "s" : "")")
            }
            if weeks > 0 {
                components.append("\(weeks) week\(weeks > 1 ? "s" : "")")
            }
            if months > 0 {
                components.append("\(months) month\(months > 1 ? "s" : "")")
            }
            return components.joined(separator: ", ")
        }
    }
    static var allCases: [Recurrence] {
        return [
            .daily,
            .weekly,
            .monthly,
            .custom(days: 0, weeks: 0, months: 0)
        ]
    }
}
