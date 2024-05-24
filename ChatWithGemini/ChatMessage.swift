import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ChatMessage: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var question: String
    var answer: String
    var timestamp: Timestamp = Timestamp()
}
