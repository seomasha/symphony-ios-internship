import SwiftUI

enum Recurrence: CaseIterable, Hashable {
    case daily
    case weekly
    case monthly
    case custom
    
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
    static var allCases: [Recurrence] {
        return [
            .daily,
            .weekly,
            .monthly,
            .custom
        ]
    }
}
