import Foundation

enum Field {
    case id, name, email
}

enum ValidationError: LocalizedError {
    case emptyField(Field)
    case invalidEmail
    case duplicateID
    case invalidMark
    case markOutOfRange
    case invalidCredits
    case invalidSemester
    case invalidAcademicYear
    case duplicateEnrollment
    case duplicateAssignment
    case notFound

    var field: Field? {
        switch self {
        case .emptyField(let field): return field
        case .invalidEmail: return .email
        case .duplicateID: return .id
        default: return nil
        }
    }

    var errorDescription: String? {
        switch self {
        case .emptyField(let field):
            switch field {
            case .id: return "ID is required"
            case .name: return "Name is required"
            case .email: return "Email is required"
            }
        case .invalidEmail: return "Enter a valid email, e.g. name@school.edu"
        case .duplicateID: return "ID already exists"
        case .invalidMark, .markOutOfRange: return "Mark must be a number from 0 to 10"
        case .invalidCredits: return "Credits must be a positive integer"
        case .invalidSemester: return "Semester must be a positive integer"
        case .invalidAcademicYear: return "Academic year must look like 2026-2027"
        case .duplicateEnrollment: return "This student is already enrolled in this subject for this academic year"
        case .duplicateAssignment: return "Subject is already assigned to this teacher"
        case .notFound: return "Record not found"
        }
    }
}
