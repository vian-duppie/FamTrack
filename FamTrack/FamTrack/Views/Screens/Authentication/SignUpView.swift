//
//  SignUpView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/08.
//

import SwiftUI

struct SignUpView: View {
    @State var usernameHint: String = ""
    @State var isUsernameError: Bool = false
    @State var emailHint: String = ""
    @State var isEmailError: Bool = false
    @State var passwordHint: String = "Please enter at least 5 characters"
    @State var isPasswordError: Bool = false
    @State var usernameValue: String = ""
    @State var emailValue: String = ""
    @State var passwordValue: String = ""
    
    @State var canSignUp: Bool = true
    
    var body: some View {
        AuthenticationLayout(
            formContent: {
                SignUpForm(
                    usernameHint: $usernameHint,
                    isUsernameError: $isUsernameError,
                    emailHint: $emailHint,
                    isEmailError: $isEmailError,
                    passwordHint: $passwordHint,
                    isPasswordError: $isPasswordError,
                    usernameValue: $usernameValue,
                    emailValue: $emailValue,
                    passwordValue: $passwordValue
                )
            },
            heading: "Sign Up",
            subHeading: "Complete the form below to create your FamTrack account",
            mainAction: handleSignUp,
            secondaryAction: AnyView(
                NavigationLink(
                     destination: LoginView(),  // Navigate to SignUpView
                     label: {
                         Text("Login")
                             .foregroundColor(.white)
                             .font(Font.custom("Poppins-Light", size: 13))
                             .opacity(0.67)
                             .underline()
                     }
                 )
            ),
            lineButtonLabel: "Already have an account?",
            lineButtonText: "Log In",
            lineButtonOpacity: 0.67,
            buttonLabel: "Sign Up"
        )
        .navigationBarHidden(true)
    }
    
    func handleSignUp() {
        clearErrors()
        canSignUp = true
        
        if usernameValue.isEmpty {
            canSignUp = false
            
            usernameHint = "Please enter a username"
            isUsernameError = true
        }
        
        if emailValue.isEmpty {
            canSignUp = false
            
            emailHint = "Please enter an email"
            isEmailError = true
        } else {
            if !emailValidator(email: emailValue) {
                emailHint = "The email address is not valid"
                isEmailError = true
            }
        }
        
        if passwordValue.isEmpty {
            canSignUp = false
            
            passwordHint = "Please enter a password"
            isPasswordError = true
        } else if passwordValue.count < 6 {
            canSignUp = false
            
            passwordHint = "Password too short \(passwordValue.count)/5"
            isPasswordError = true
        }
        
        if !canSignUp {
            return
        }
    }
    
    private func clearErrors() {
        isUsernameError = false
        isEmailError = false
        isPasswordError = false
        usernameHint = ""
        emailHint = ""
        passwordHint = "Enter at least 5 characters"
    }
    
    func emailValidator(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let regex = try! NSRegularExpression(pattern: emailRegEx)
        let nsRange = NSRange(location: 0, length: email.count)
        let emailResult = regex.matches(in: email, range: nsRange)
        
        if emailResult.count == 0 {
            return false
        }
        
        return true
    }
}

struct SignUpForm: View {
    @Binding var usernameHint: String
    @Binding var isUsernameError: Bool
    @Binding var emailHint: String
    @Binding var isEmailError: Bool
    @Binding var passwordHint: String
    @Binding var isPasswordError: Bool
    @State var isPassword: Bool = true
    @Binding var usernameValue: String
    @Binding var emailValue: String
    @Binding var passwordValue: String
    
    var body: some View {
        VStack(spacing: 15) {
            CustomInput(
                label: "Username",
                placeholder: "Enter your username",
                showingError: isUsernameError,
                hintLabel: usernameHint,
                value: $usernameValue
            )
            
            CustomInput(
                label: "Email",
                placeholder: "johndoe@gmail.com",
                showingError: isEmailError,
                hintLabel: emailHint,
                value: $emailValue
            )
            
            CustomInput(
                isPasswordInput: isPassword,
                label: "Password",
                placeholder: "Create your password here",
                icon: isPassword ? "eye" : "eye.slash",
                showingError: isPasswordError,
                iconClicked: togglePasswordShow,
                hintLabel: passwordHint,
                value: $passwordValue
            )
        }
    }
    
    private func togglePasswordShow() {
        isPassword.toggle()
    }
}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
