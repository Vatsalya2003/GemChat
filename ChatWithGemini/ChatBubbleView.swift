import SwiftUI

struct ChatBubbleView: View {
    var question: String
    var answer: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Spacer()
                Text(question)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(16)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.trailing)  // Added to align text within bubble
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.75, alignment: .trailing)  // To limit width
            }
            
            HStack {
                Text(answer)
                    .padding(10)
                    .background(Color.indigo.opacity(0.9))
                    .cornerRadius(16)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)  // Added to align text within bubble
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.75, alignment: .leading)  // To limit width
                Spacer()
            }
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 10)  // Added to provide padding on the sides
        .background(Color.black.ignoresSafeArea())
    }
}

struct ChatBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        ChatBubbleView(question: "Sample Question?", answer: "Sample Answer.")
            .previewLayout(.sizeThatFits)  // Added to ensure proper preview
    }
}
