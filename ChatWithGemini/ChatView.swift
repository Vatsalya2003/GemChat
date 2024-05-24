import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import GoogleGenerativeAI

struct ChatView: View {
    @Binding var isLoggedIn: Bool
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    
    @State private var userPrompt: String = ""
    @State private var chatHistory: [ChatMessage] = []
    @State private var isLoading = false
    @State private var response: LocalizedStringKey = "How can I help you today?"
    private let db = Firestore.firestore()

    var body: some View {
        VStack {
            ZStack {
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(chatHistory.indices, id: \.self) { index in
                            ChatBubbleView(question: chatHistory[index].question, answer: chatHistory[index].answer)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
                        .scaleEffect(2)
                        .offset(y: -50)
                }
            }
            MessageInputView(userPrompt: $userPrompt, generateResponse: generateResponse)
                .padding()
        }
        .background(Color.black.ignoresSafeArea())
        .navigationTitle("Chat")
        .onAppear {
            loadChats()
        }
    }

    func generateResponse() {
        isLoading = true
        Task {
            do {
                let result = try await model.generateContent(userPrompt)
                isLoading = false
                let answer = result.text ?? "No Response Found"
                response = LocalizedStringKey(answer)
                let newMessage = ChatMessage(id: UUID().uuidString, question: userPrompt, answer: answer)
                chatHistory.append(newMessage)
                saveChat(newMessage)
                userPrompt = ""
            } catch {
                isLoading = false
                response = LocalizedStringKey("Something went wrong\n\(error.localizedDescription)")
            }
        }
    }

    func saveChat(_ message: ChatMessage) {
        guard let user = Auth.auth().currentUser else {
            print("No user is logged in")
            return
        }
        
        do {
            if let messageId = message.id {
                try db.collection("users").document(user.uid).collection("chats").document(messageId).setData(from: message)
            } else {
                print("Error: message.id is nil")
            }
        } catch let error {
            print("Error saving chat: \(error)")
        }
    }

    func loadChats() {
        guard let user = Auth.auth().currentUser else {
            print("No user is logged in")
            return
        }
        
        db.collection("users").document(user.uid).collection("chats").order(by: "timestamp").getDocuments { snapshot, error in
            if let error = error {
                print("Error loading chats: \(error)")
                return
            }
            guard let documents = snapshot?.documents else { return }
            self.chatHistory = documents.compactMap { document in
                try? document.data(as: ChatMessage.self)
            }
        }
    }
}
