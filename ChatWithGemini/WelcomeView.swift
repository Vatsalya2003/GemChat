import SwiftUI

struct WelcomeView: View {
    @Binding var showWelcome: Bool
    @Binding var currentView: AuthView

    var body: some View {
        VStack {
            Spacer()

            Image(systemName: "robot") // Replace with your custom image
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)

            Text("Welcome to AI Chat Bot")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text("Lorem Ipsum is simply dummy text of the printing and")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 20)

            Spacer()

            Button(action: {
                showWelcome = false
                currentView = .signUp // or .login based on where you want to navigate
            }) {
                Text("Get Started")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.indigo)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.bottom, 30)
        }
        .background(Color.white.ignoresSafeArea())
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(showWelcome: .constant(true), currentView: .constant(.login))
    }
}
