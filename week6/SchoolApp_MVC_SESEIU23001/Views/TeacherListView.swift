import SwiftUI

struct TeacherListView: View {
    @EnvironmentObject var repository: SchoolRepository

    var body: some View {
        NavigationStack {
            List(repository.teachers) { teacher in
                NavigationLink(value: teacher.id) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(teacher.name).font(.headline)
                            Text("\(teacher.id) · \(teacher.email)").font(.caption).foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text("\(teacher.subjectIDs.count) subjects").foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Teachers")
            .navigationDestination(for: String.self) { TeacherAssignView(teacherID: $0) }
        }
    }
}
