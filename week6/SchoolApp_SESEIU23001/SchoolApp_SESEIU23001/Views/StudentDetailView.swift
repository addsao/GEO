import SwiftUI

struct StudentDetailView: View {
    @EnvironmentObject var repository: SchoolRepository
    let studentID: String
    @State private var showingEdit = false
    @State private var showingEnroll = false

    var body: some View {
        if let student = repository.student(studentID) {
            let results = EnrollmentController(repository: repository).results(forStudent: studentID)
            List {
                Section {
                    Text(student.name).font(.title3.bold())
                    Text("ID: \(student.id)")
                    Text(student.email)
                }
                Section("Enrolled subjects") {
                    if results.isEmpty {
                        Text("No enrollments yet").foregroundStyle(.secondary)
                    }
                    ForEach(results) { result in
                        NavigationLink {
                            MarkEntryView(enrollmentID: result.enrollment.id)
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(result.subject.title)
                                    Text(result.enrollment.academicYear).font(.caption).foregroundStyle(.secondary)
                                }
                                Spacer()
                                Text(result.enrollment.mark.map { String(format: "%.1f", $0) } ?? "—")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Student")
            .toolbar {
                Button("Enroll", systemImage: "plus") { showingEnroll = true }
                Button("Edit") { showingEdit = true }
            }
            .sheet(isPresented: $showingEdit) { StudentFormView(student: student) }
            .sheet(isPresented: $showingEnroll) { EnrollmentFormView(studentID: studentID) }
        }
    }
}
