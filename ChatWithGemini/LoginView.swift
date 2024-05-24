import SwiftUI
import Firebase

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Binding var switchView: AuthView
    @State private var email = ""
    @State private var password = ""
    @State private var loginFailed = false
    @State private var errorMessage = ""
    @State private var isPasswordVisible = false

    var body: some View {
        VStack {
            Text("Welcome back to login!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white) // Change text color to white
                .padding(.top, 40)

            Spacer().frame(height: 20)

            Image("robo1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .padding(.top, 10)

            Text("Login to your account. Get easier than search engines results.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            TextField("Enter your email", text: $email)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .foregroundColor(.black) // Change text color to white
                .accentColor(.blue)

            ZStack {
                if isPasswordVisible {
                    TextField("Enter your password", text: $password)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .foregroundColor(.black) // Change text color to white
                        .accentColor(.blue)
                } else {
                    SecureField("Enter your password", text: $password)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .foregroundColor(.black) // Change text color to white
                        .accentColor(.blue)
                }

                HStack {
                    Spacer()
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                .padding(.trailing, 20)
            }

            if loginFailed {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
                    .padding(.horizontal)
            }

            Button(action: {
                login()
            }) {
                Text("Login")
                    .foregroundColor(.white) // Change button text color to white
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.indigo)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.top)

            Spacer()

            Button(action: {
                switchView = .signUp
            }) {
                Text("Don't have an account? Create an account")
                    .foregroundColor(.indigo)
            }
            .padding(.bottom, 20)
        }
        .background(Color.black.ignoresSafeArea()) // Change background color to black
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                loginFailed = true
                errorMessage = error.localizedDescription
                return
            }
            isLoggedIn = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: .constant(false), switchView: .constant(.signUp))
    }
}
