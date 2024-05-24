import SwiftUI
import Firebase

struct SignUpView: View {
    @Binding var isLoggedIn: Bool
    @Binding var switchView: AuthView
    @State private var email = ""
    @State private var password = ""
    @State private var signUpFailed = false
    @State private var errorMessage = ""
    @State private var isPasswordVisible = false
    @State private var passwordStrengthMessage = ""
    @State private var passwordStrengthColor = Color.gray

    var body: some View {
        VStack {
            Image("robo2") 
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .padding(.top, 60)
            
            Text("Welcome to Gemini AI!")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
                .foregroundColor(.white)
            
            Text("Create a new account. Start using AI-powered tools.")
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
            
            ZStack {
                if isPasswordVisible {
                    TextField("Create your password", text: $password, onEditingChanged: { _ in
                        checkPasswordStrength(password)
                    })
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                } else {
                    SecureField("Create your password", text: $password, onCommit: {
                        checkPasswordStrength(password)
                    })
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
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
            
            HStack {
                Text(passwordStrengthMessage)
                    .foregroundColor(passwordStrengthColor)
                Spacer()
            }
            .padding(.horizontal)
            
            if signUpFailed {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
                    .padding(.horizontal)
            }
            
            Button(action: {
                signUp()
            }) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.indigo)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.top)
            
            Spacer()
            
            Button(action: {
                switchView = .login
            }) {
                Text("Already have an account? Login")
                    .foregroundColor(.indigo)
            }
            .padding(.bottom, 20)
        }
        .background(Color.black.ignoresSafeArea())
    }
    
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                signUpFailed = true
                errorMessage = error.localizedDescription
                return
            }
            isLoggedIn = true
        }
    }
    
    func checkPasswordStrength(_ password: String) {
        if password.count < 6 {
            passwordStrengthMessage = "Weak password"
            passwordStrengthColor = .red
        } else if password.count < 12 {
            passwordStrengthMessage = "Moderate password"
            passwordStrengthColor = .orange
        } else {
            passwordStrengthMessage = "Strong password"
            passwordStrengthColor = .green
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(isLoggedIn: .constant(false), switchView: .constant(.login))
    }
}
