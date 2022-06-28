import Foundation

public enum ServerError: Error {
    case networkProblem
    case serverFail
    case noReceipt
    case invalidRequest((Int, String))
    
}

// MARK: - LocalizedError

extension ServerError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .networkProblem: return ""
        case .serverFail: return ""
        case .noReceipt: return ""
        case .invalidRequest((_, let message)): return message
        }
    }
}

// MARK: - Equatable

extension ServerError: Equatable {
    
    public static func == (lhs: ServerError, rhs: ServerError) -> Bool {
        switch (lhs, rhs) {
        case (.networkProblem, .networkProblem):
            return true
        case (.serverFail, .serverFail):
            return true
        case (.noReceipt, .noReceipt):
            return true
        case (.invalidRequest((let code1, let message1)), .invalidRequest((let code2, let message2))):
            if code1 == code2, message1 == message2 { return true }
            return false
        default:
            return false
        }
    }
}
