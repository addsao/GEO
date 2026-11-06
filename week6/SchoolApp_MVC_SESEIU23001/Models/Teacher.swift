struct Teacher: Identifiable, Describable {
    let id: String
    let name: String
    let email: String
    private(set) var subjectIDs: Set<String> = []

    init(id: String, name: String, email: String) throws {
        self.id = try Validator.nonEmpty(id, field: .id)
        self.name = try Validator.nonEmpty(name, field: .name)
        self.email = try Validator.email(email)
    }

    mutating func assign(subjectID: String) throws {
        guard subjectIDs.insert(subjectID).inserted else { throw ValidationError.duplicateAssignment }
    }

    mutating func unassign(subjectID: String) {
        subjectIDs.remove(subjectID)
    }

    func describe() -> String { "\(id) – \(name)" }
}
