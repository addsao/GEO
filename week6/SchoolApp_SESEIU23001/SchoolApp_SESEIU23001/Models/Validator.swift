import Foundation

enum Validator {
    static func nonEmpty(_ value: String, field: Field) throws -> String {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { throw ValidationError.emptyField(field) }
        return trimmed
    }

    static func email(_ value: String) throws -> String {
        let trimmed = try nonEmpty(value, field: .email)
        let pattern = #"^[^@\s]+@[^@\s]+\.[^@\s]+$"#
        guard trimmed.range(of: pattern, options: .regularExpression) != nil else {
            throw ValidationError.invalidEmail
        }
        return trimmed
    }

    static func mark(_ value: Double) throws -> Double {
        guard value >= 0, value <= 10 else { throw ValidationError.markOutOfRange }
        return value
    }

    static func academicYear(_ value: String) throws -> String {
        let parts = value.split(separator: "-")
        guard parts.count == 2, let start = Int(parts[0]), let end = Int(parts[1]),
              parts[0].count == 4, end == start + 1 else {
            throw ValidationError.invalidAcademicYear
        }
        return value
    }
}
