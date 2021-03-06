import Firebase
import Foundation
enum MessageType: String {
    case sent
    case received
}
struct Message: Hashable {
    let text: String
    let type: MessageType
    let created: Date //Date
}
