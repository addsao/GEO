import SwiftUI

struct SubjectListView: View {
    @EnvironmentObject var repository: SchoolRepository

    var body: some View {
        NavigationStack {
            List(repository.subjects) { subject in
                let teachers = TeachingController(repository: repository).teachers(forSubject: subject.id)
                VStack(alignment: .leading, spacing: 4) {
                    Text(subject.title).font(.headline)
                    Text("\(subject.id) · \(subject.credits) credits · Semester \(subject.semester)")
                        .font(.subheadline).foregroundStyle(.secondary)
                    Text("Taught by: " + (teachers.isEmpty ? "—" : teachers.map(\.name).joined(separator: ", ")))
                        .font(.caption).foregroundStyle(.blue)
                }
            }
            .navigationTitle("Subjects")
        }
    }
}
