import SwiftUI

struct MarkEntryView: View {
    @EnvironmentObject var repository: SchoolRepository
    @Environment(\.dismiss) private var dismiss
    let enrollmentID: UUID
    @State private var text = ""
    @State private var error: ValidationError?

    private var enrollment: Enrollment? { repository.enrollments.first { $0.id == enrollmentID } }

    var body: some View {
        if let enrollment {
            Form {
                Section {
                    Text(repository.student(enrollment.studentID)?.describe() ?? enrollment.studentID)
                    Text(repository.subject(enrollment.subjectID)?.describe() ?? enrollment.subjectID)
                    Text("Academic year: \(enrollment.academicYear)")
                }
                Section("Mark (0–10)") {
                    TextField("Mark", text: $text).keyboardType(.decimalPad)
                    if let error { Text(error.errorDescription ?? "").font(.footnote).foregroundStyle(.red) }
                }
            }
            .navigationTitle("Enrollment")
            .toolbar { Button("Save", action: save) }
            .onAppear { text = enrollment.mark.map { String($0) } ?? "" }
        }
    }

    private func save() {
        do {
            try EnrollmentController(repository: repository).updateMark(enrollmentID: enrollmentID, text: text)
            dismiss()
        } catch let validation as ValidationError {
            error = validation
        } catch {}
    }
}
