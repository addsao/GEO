import SwiftUI

struct EnrollmentFormView: View {
    @EnvironmentObject var repository: SchoolRepository
    @Environment(\.dismiss) private var dismiss
    let studentID: String?
    @State private var selectedStudent = ""
    @State private var selectedSubject = ""
    @State private var year = "2026-2027"
    @State private var error: ValidationError?

    var body: some View {
        NavigationStack {
            Form {
                if let error {
                    Section { Text(error.errorDescription ?? "").foregroundStyle(.red) }
                }
                Picker("Student", selection: $selectedStudent) {
                    ForEach(repository.students) { Text($0.describe()).tag($0.id) }
                }
                Picker("Subject", selection: $selectedSubject) {
                    ForEach(repository.subjects) { Text($0.describe()).tag($0.id) }
                }
                Picker("Academic year", selection: $year) {
                    ForEach(SchoolRepository.academicYears, id: \.self) { Text($0) }
                }
            }
            .navigationTitle("Enroll Student")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) { Button("Enroll", action: enroll) }
            }
            .onAppear {
                selectedStudent = studentID ?? repository.students.first?.id ?? ""
                selectedSubject = repository.subjects.first?.id ?? ""
            }
        }
    }

    private func enroll() {
        do {
            try EnrollmentController(repository: repository)
                .enroll(studentID: selectedStudent, subjectID: selectedSubject, year: year)
            dismiss()
        } catch let validation as ValidationError {
            error = validation
        } catch {}
    }
}
