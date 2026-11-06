import Foundation

struct Enrollment: Identifiable, Describable {
    let id = UUID()
    let studentID: String
    let subjectID: String
    let academicYear: String
    private(set) var mark: Double?

    init(studentID: String, subjectID: String, academicYear: String) throws {
        self.studentID = try Validator.nonEmpty(studentID, field: .id)
        self.subjectID = try Validator.nonEmpty(subjectID, field: .id)
        self.academicYear = try Validator.academicYear(academicYear)
    }

    mutating func updateMark(_ value: Double) throws {
        mark = try Validator.mark(value)
    }

    func describe() -> String { "\(studentID) · \(subjectID) · \(academicYear)" }
}
