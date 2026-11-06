import SwiftUI

struct EnrollmentListView: View {
    @EnvironmentObject var repository: SchoolRepository
    @State private var showingForm = false

    var body: some View {
        NavigationStack {
            List(repository.enrollments) { enrollment in
                NavigationLink {
                    MarkEntryView(enrollmentID: enrollment.id)
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(repository.student(enrollment.studentID)?.name ?? enrollment.studentID) · \(enrollment.studentID)")
                                .font(.headline)
                            Text("\(enrollment.subjectID) · \(enrollment.academicYear)")
                                .font(.caption).foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text(enrollment.mark.map { String(format: "%.1f", $0) } ?? "—").foregroundStyle(.secondary)
                    }
                }
            }
            .overlay {
                if repository.enrollments.isEmpty { ContentUnavailableView("No enrollments yet", systemImage: "list.clipboard") }
            }
            .navigationTitle("Enrollments")
            .toolbar { Button("Enroll", systemImage: "plus") { showingForm = true } }
            .sheet(isPresented: $showingForm) { EnrollmentFormView(studentID: nil) }
        }
    }
}
