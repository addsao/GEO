import SwiftUI

struct StudentFormView: View {
    @EnvironmentObject var repository: SchoolRepository
    @Environment(\.dismiss) private var dismiss
    let student: Student?
    @State private var id = ""
    @State private var name = ""
    @State private var email = ""
    @State private var error: ValidationError?

    private func message(for field: Field) -> String? {
        error?.field == field ? error?.errorDescription : nil
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Student ID", text: $id).disabled(student != nil).textInputAutocapitalization(.characters)
                    errorText(message(for: .id))
                }
                Section {
                    TextField("Name", text: $name)
                    errorText(message(for: .name))
                }
                Section {
                    TextField("Email", text: $email).keyboardType(.emailAddress).textInputAutocapitalization(.never)
                    errorText(message(for: .email))
                }
            }
            .navigationTitle(student == nil ? "New Student" : "Edit Student")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) { Button("Save", action: save) }
            }
            .onAppear {
                guard let student else { return }
                id = student.id
                name = student.name
                email = student.email
            }
        }
    }

    @ViewBuilder
    private func errorText(_ text: String?) -> some View {
        if let text { Text(text).font(.footnote).foregroundStyle(.red) }
    }

    private func save() {
        let controller = StudentController(repository: repository)
        do {
            if student == nil {
                try controller.add(id: id, name: name, email: email)
            } else {
                try controller.update(id: id, name: name, email: email)
            }
            dismiss()
        } catch let validation as ValidationError {
            error = validation
        } catch {
            self.error = .notFound
        }
    }
}
