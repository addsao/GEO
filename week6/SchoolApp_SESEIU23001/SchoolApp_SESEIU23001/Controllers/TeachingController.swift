struct TeachingController {
    let repository: SchoolRepository

    func teachers(forSubject id: String) -> [Teacher] {
        repository.teachers.filter { $0.subjectIDs.contains(id) }
    }

    func assign(subjectIDs: Set<String>, toTeacher id: String) throws {
        guard let index = repository.teachers.firstIndex(where: { $0.id == id }) else {
            throw ValidationError.notFound
        }
        var teacher = repository.teachers[index]
        for subjectID in teacher.subjectIDs.subtracting(subjectIDs) { teacher.unassign(subjectID: subjectID) }
        for subjectID in subjectIDs.subtracting(teacher.subjectIDs) { try teacher.assign(subjectID: subjectID) }
        repository.teachers[index] = teacher
    }
}
