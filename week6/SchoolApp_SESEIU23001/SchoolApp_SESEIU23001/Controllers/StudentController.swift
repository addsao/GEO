import Foundation
struct StudentController {
    let repository: SchoolRepository

    func students(matching query: String) -> [Student] {
        let text = query.trimmingCharacters(in: .whitespaces).lowercased()
        guard !text.isEmpty else { return repository.students }
        return repository.students.filter {
            $0.id.lowercased().contains(text) || $0.name.lowercased().contains(text)
        }
    }

    func add(id: String, name: String, email: String) throws {
        let student = try Student(id: id, name: name, email: email)
        guard repository.student(student.id) == nil else { throw ValidationError.duplicateID }
        repository.students.append(student)
    }

    func update(id: String, name: String, email: String) throws {
        guard let index = repository.students.firstIndex(where: { $0.id == id }) else {
            throw ValidationError.notFound
        }
        try repository.students[index].update(name: name, email: email)
    }
}
