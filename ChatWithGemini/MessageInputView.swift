import SwiftUI

struct MessageInputView: View {
    @Binding var userPrompt: String
    var generateResponse: () -> Void

    var body: some View {
        HStack {
            TextField("Enter your message", text: $userPrompt)
                .padding(8)
                .background(Color.white)
                .cornerRadius(12)
            Button(action: {
                generateResponse()
            }) {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.indigo)
                    .clipShape(Circle())
            }
        }
        .padding(8)
    }
}

struct MessageInputView_Previews: PreviewProvider {
    static var previews: some View {
        MessageInputView(userPrompt: .constant(""), generateResponse: {})
    }
}
