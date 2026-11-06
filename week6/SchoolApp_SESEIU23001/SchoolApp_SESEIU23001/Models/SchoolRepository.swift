import Foundation
import Combine

final class SchoolRepository: ObservableObject {
    @Published var students: [Student] = []
    @Published var teachers: [Teacher] = []
    @Published var subjects: [Subject] = []
    @Published var enrollments: [Enrollment] = []

    static let academicYears = ["2025-2026", "2026-2027", "2027-2028"]

    init() {
        loadSampleData()
    }

    func student(_ id: String) -> Student? { students.first { $0.id == id } }
    func subject(_ id: String) -> Subject? { subjects.first { $0.id == id } }

    private func loadSampleData() {
        let names = ["Nguyen Van An", "Tran Thi Binh", "Le Minh Chau", "Pham Quoc Dung", "Vo Thu Ha"]
        students = names.enumerated().compactMap {
            try? Student(id: String(format: "ST%03d", $0.offset + 1), name: $0.element,
                         email: "student\($0.offset + 1)@school.edu")
        }
        subjects = [
            try? Subject(id: "SUB101", title: "Mobile Programming", credits: 3, semester: 1),
            try? Subject(id: "SUB102", title: "Databases", credits: 4, semester: 1),
            try? Subject(id: "SUB103", title: "Software Engineering", credits: 3, semester: 2),
            try? Subject(id: "SUB104", title: "Web Development", credits: 3, semester: 2)
        ].compactMap { $0 }
        let teacherData = [("TCH01", "Dr. Hoang Minh", ["SUB101", "SUB102"]),
                           ("TCH02", "Ms. Pham Lan", ["SUB101", "SUB104"]),
                           ("TCH03", "Mr. Do Quang", ["SUB103", "SUB104"])]
        teachers = teacherData.compactMap { id, name, subjectIDs in
            guard var teacher = try? Teacher(id: id, name: name, email: "\(id.lowercased())@school.edu") else { return nil }
            subjectIDs.forEach { try? teacher.assign(subjectID: $0) }
            return teacher
        }
        for student in students {
            for subject in subjects.prefix(2) {
                if var enrollment = try? Enrollment(studentID: student.id, subjectID: subject.id, academicYear: "2026-2027") {
                    try? enrollment.updateMark(Double.random(in: 5...10).rounded())
                    enrollments.append(enrollment)
                }
            }
        }
    }
}
