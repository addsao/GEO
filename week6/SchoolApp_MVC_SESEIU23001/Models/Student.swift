struct Student: Identifiable, Describable {
    let id: String
    private(set) var name: String
    private(set) var email: String

    init(id: String, name: String, email: String) throws {
        self.id = try Validator.nonEmpty(id, field: .id)
        self.name = try Validator.nonEmpty(name, field: .name)
        self.email = try Validator.email(email)
    }

    mutating func update(name: String, email: String) throws {
        let newName = try Validator.nonEmpty(name, field: .name)
        let newEmail = try Validator.email(email)
        self.name = newName
        self.email = newEmail
    }

    func describe() -> String { "\(id) – \(name)" }
}
