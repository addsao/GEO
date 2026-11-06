import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            StudentListView().tabItem { Label("Students", systemImage: "person.2") }
            SubjectListView().tabItem { Label("Subjects", systemImage: "book") }
            TeacherListView().tabItem { Label("Teachers", systemImage: "person.crop.rectangle") }
            EnrollmentListView().tabItem { Label("Enrollments", systemImage: "list.clipboard") }
        }
    }
}
