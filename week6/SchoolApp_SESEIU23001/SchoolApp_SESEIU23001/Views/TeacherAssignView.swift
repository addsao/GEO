import SwiftUI

struct TeacherAssignView: View {
    @EnvironmentObject var repository: SchoolRepository
    @Environment(\.dismiss) private var dismiss
    let teacherID: String
    @State private var selected: Set<String> = []
    @State private var error: ValidationError?

    var body: some View {
        List {
            Section("Assigned subjects") {
                ForEach(repository.subjects) { subject in
                    Button {
                        if selected.contains(subject.id) { selected.remove(subject.id) } else { selected.insert(subject.id) }
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(subject.title)
                                Text(subject.id).font(.caption).foregroundStyle(.secondary)
                            }
                            Spacer()
                            Image(systemName: selected.contains(subject.id) ? "checkmark.circle.fill" : "circle")
                        }
                    }
                    .foregroundStyle(.primary)
                }
            }
            if let error { Text(error.errorDescription ?? "").foregroundStyle(.red) }
        }
        .navigationTitle(repository.teachers.first { $0.id == teacherID }?.name ?? "Teacher")
        .toolbar { Button("Save", action: save) }
        .onAppear { selected = repository.teachers.first { $0.id == teacherID }?.subjectIDs ?? [] }
    }

    private func save() {
        do {
            try TeachingController(repository: repository).assign(subjectIDs: selected, toTeacher: teacherID)
            dismiss()
        } catch let validation as ValidationError {
            error = validation
        } catch {}
    }
}
