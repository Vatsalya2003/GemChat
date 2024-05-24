import SwiftUI

struct ChatDetailView: View {
    var chatMessage: ChatMessage
    
    var body: some View {
        ScrollView { // Wrap content in a ScrollView
            VStack(alignment: .leading, spacing: 10) {
                Text(LocalizedStringKey("Question"))
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Text(chatMessage.question)
                    .font(.body)
                    .foregroundColor(Color.white)
                Text(LocalizedStringKey("Answer"))
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Text(chatMessage.answer)
                    .font(.body)
                    .foregroundColor(Color.white)
                Spacer()
            }
            .padding()
        }
        .background(Color.black) // Set the background color to black
        .navigationTitle(LocalizedStringKey("Chat Details"))
        .navigationBarTitleDisplayMode(.inline) // Ensure the title is displayed inline
    }
}
