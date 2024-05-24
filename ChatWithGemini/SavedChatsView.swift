import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct SavedChatsView: View {
    @State private var savedChats: [ChatMessage] = []
    private let db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
            VStack {
                if savedChats.isEmpty {
                    Text("No Saved Chats")
                        .font(.title)
                        .foregroundColor(.indigo)
                } else {
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(savedChats) { chat in
                                NavigationLink(destination: ChatDetailView(chatMessage: chat)) {
                                    HStack {
                                        Image(systemName: "folder.fill")
                                            .foregroundColor(.yellow)
                                            .padding(.trailing, 5)
                                        VStack(alignment: .leading) {
                                            Text(chat.question)
                                                .font(.headline)
                                                .foregroundColor(.black)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            Text(chat.timestamp.dateValue(), style: .date)
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.white.opacity(0.9))
                                    .cornerRadius(10)
                                    .padding(.horizontal, 10) // Add horizontal padding to show black background on sides
                                }
                            }
                        }
                        .padding(.top, 10)
                    }
                    .background(Color.black)
                }
            }
            .background(Color.black)
            .navigationTitle("Saved Chats")
            .onAppear {
                loadSavedChats()
            }
        }
        .background(Color.black)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func loadSavedChats() {
        guard let user = Auth.auth().currentUser else {
            print("No user is logged in")
            return
        }
        
        db.collection("users").document(user.uid).collection("chats").order(by: "timestamp").getDocuments { snapshot, error in
            if let error = error {
                print("Error loading saved chats: \(error)")
                return
            }
            guard let documents = snapshot?.documents else { return }
            self.savedChats = documents.compactMap { document in
                try? document.data(as: ChatMessage.self)
            }
        }
    }
}
