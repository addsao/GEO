import SwiftUI

struct StudentListView: View {
    @EnvironmentObject var repository: SchoolRepository
    @State private var query = ""
    @State private var showingForm = false

    private var students: [Student] {
        StudentController(repository: repository).students(matching: query)
    }

    var body: some View {
        NavigationStack {
            List(students) { student in
                NavigationLink(value: student.id) {
                    VStack(alignment: .leading) {
                        Text(student.name).font(.headline)
                        Text(student.id).font(.subheadline).foregroundStyle(.secondary)
                    }
                }
            }
            .overlay {
                if students.isEmpty {
                    ContentUnavailableView(query.isEmpty ? "No students yet" : "No students found",
                                           systemImage: "person.slash")
                }
            }
            .navigationTitle("Students")
            .navigationDestination(for: String.self) { StudentDetailView(studentID: $0) }
            .searchable(text: $query, prompt: "Search students")
            .toolbar {
                Button("Add", systemImage: "plus") { showingForm = true }
            }
            .sheet(isPresented: $showingForm) { StudentFormView(student: nil) }
        }
    }
}
