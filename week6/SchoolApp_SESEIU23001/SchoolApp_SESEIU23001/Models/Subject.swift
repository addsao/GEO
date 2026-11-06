struct Subject: Identifiable, Describable {
    let id: String
    let title: String
    let credits: Int
    let semester: Int

    init(id: String, title: String, credits: Int, semester: Int) throws {
        guard credits > 0 else { throw ValidationError.invalidCredits }
        guard semester > 0 else { throw ValidationError.invalidSemester }
        self.id = try Validator.nonEmpty(id, field: .id)
        self.title = try Validator.nonEmpty(title, field: .name)
        self.credits = credits
        self.semester = semester
    }

    func describe() -> String { "\(id) – \(title)" }
}
