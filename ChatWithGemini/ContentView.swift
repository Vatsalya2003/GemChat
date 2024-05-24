import SwiftUI
import Firebase

enum AuthView {
    case login
    case signUp
}

struct ContentView: View {
    @State private var currentView: AuthView = .login
    @State private var isLoggedIn = false

    init() {
        // Configure the appearance of the navigation bar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemIndigo]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemIndigo]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

        // Set the color for unselected tab bar items with adjusted opacity
             let unselectedColor = UIColor.systemIndigo.withAlphaComponent(0.4) // Adjust opacity here
             UITabBar.appearance().unselectedItemTintColor = unselectedColor
    }

    var body: some View {
        NavigationView {
            if isLoggedIn {
                TabView {
                    ChatView(isLoggedIn: $isLoggedIn)
                        .tabItem {
                            Label("Chat", systemImage: "bubble.left.and.bubble.right")
                        }
                    SavedChatsView()
                        .tabItem {
                            Label("Saved Chats", systemImage: "tray.full")
                        }
                }
                .navigationBarTitle("Gemini AI", displayMode: .inline)
                .navigationBarItems(
                    trailing: Button(action: {
                        logout()
                    }) {
                        Text("Logout")
                            .foregroundColor(.red)
                    }
                )
            } else {
                VStack {
                    if currentView == .login {
                        LoginView(isLoggedIn: $isLoggedIn, switchView: $currentView)
                    } else {
                        SignUpView(isLoggedIn: $isLoggedIn, switchView: $currentView)
                    }
                    Spacer()
                }
                .navigationTitle("Gemini AI")
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.indigo.opacity(0.7)]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                        .ignoresSafeArea()
                )
                .onAppear {
                    checkUserStatus()
                }
            }
        }
        .background(Color.black) // Ensures the NavigationView background is black
    }

    func checkUserStatus() {
        if Auth.auth().currentUser != nil {
            isLoggedIn = true
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
