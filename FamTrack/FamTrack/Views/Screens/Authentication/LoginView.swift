//
//  LoginView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/08.
//

import SwiftUI
import Foundation

struct LoginView: View {
    @State var emailHint: String = ""
    @State var isEmailError: Bool = false
    @State var passwordHint: String = ""
    @State var isPasswordError: Bool = false
    @State var emailValue: String = ""
    @State var passwordValue: String = ""
    
    @State var canLogin: Bool = true
    
    var body: some View {
        AuthenticationLayout(
            formContent: {
                LoginForm(
                    emailHint: $emailHint,
                    isEmailError: $isEmailError,
                    passwordHint: $passwordHint,
                    isPasswordError: $isPasswordError,
                    emailValue: $emailValue,
                    passwordValue: $passwordValue
                )
            },
            heading: "Log In",
            subHeading: "Complete the form below to log in",
            mainAction: handleLogin,
            lineButtonLabel: "Don't have an account?",
            lineButtonText: "Sign Up",
            lineButtonOpacity: 0.67,
            buttonLabel: "Log In"
        )
    }
    
    private func handleLogin() {
        clearErrors()
        canLogin = true
        
        if emailValue.isEmpty {
            canLogin = false
            
            emailHint = "Please enter an email"
            isEmailError = true
        } else {
            if !emailValidator(email: emailValue) {
                emailHint = "The email address is not valid"
                isEmailError = true
            }
        }
        
        if passwordValue.isEmpty {
            canLogin = false
            
            passwordHint = "Please enter a password"
            isPasswordError = true
        }
        
        if !canLogin {
            return
        }
    }
    
    private func clearErrors() {
        isEmailError = false
        isPasswordError = false
        emailHint = ""
        passwordHint = ""
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

struct LoginForm: View {
    @Binding var emailHint: String
    @Binding var isEmailError: Bool
    @Binding var passwordHint: String
    @Binding var isPasswordError: Bool
    @State var isPassword: Bool = true
    @Binding var emailValue: String
    @Binding var passwordValue: String
    
    var body: some View {
        VStack(spacing: 15) {
            CustomInput(
                label: "Email",
                placeholder: "Enter your email",
                showingError: isEmailError,
                hintLabel: emailHint,
                value: $emailValue
            )
            
            CustomInput(
                isPasswordInput: isPassword,
                label: "Password",
                placeholder: "Enter your passwords",
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

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthenticationLayout()
//    }
//}
