import Foundation

struct EnrollmentResult: Identifiable {
    let enrollment: Enrollment
    let subject: Subject
    var id: UUID { enrollment.id }
}

struct EnrollmentController {
    let repository: SchoolRepository

    func enroll(studentID: String, subjectID: String, year: String) throws {
        guard repository.student(studentID) != nil, repository.subject(subjectID) != nil else {
            throw ValidationError.notFound
        }
        let enrollment = try Enrollment(studentID: studentID, subjectID: subjectID, academicYear: year)
        let exists = repository.enrollments.contains {
            $0.studentID == studentID && $0.subjectID == subjectID && $0.academicYear == year
        }
        guard !exists else { throw ValidationError.duplicateEnrollment }
        repository.enrollments.append(enrollment)
    }

    func updateMark(enrollmentID: UUID, text: String) throws {
        guard let index = repository.enrollments.firstIndex(where: { $0.id == enrollmentID }) else {
            throw ValidationError.notFound
        }
        guard let value = Double(text.replacingOccurrences(of: ",", with: ".")) else {
            throw ValidationError.invalidMark
        }
        try repository.enrollments[index].updateMark(value)
    }

    func results(forStudent id: String) -> [EnrollmentResult] {
        repository.enrollments.filter { $0.studentID == id }.compactMap { enrollment in
            repository.subject(enrollment.subjectID).map { EnrollmentResult(enrollment: enrollment, subject: $0) }
        }
    }
}
