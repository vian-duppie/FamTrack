//
//  UserStateViewModel.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/09.
//

import Foundation
import Firebase
import FirebaseFirestore

@MainActor
class UserStateViewModel: ObservableObject {
    private let db = Firestore.firestore()
    @Published var showLogin = true
    @Published var isLoggedIn = false
    @Published var isBusy = false
    @Published var userDetails: User
    @Published var username = ""
    
    init() {
        userDetails = User()
        checkAuth()
    }
    
    func getUserDetails() {
        let userId = getUserId()

        db.collection("users").document(userId).getDocument { [weak self] document, error in
            guard let self = self else { return }

            if let document = document, document.exists {
                if let username = document.data()?["username"] as? String {
                    DispatchQueue.main.async { // Make sure to update UI on the main thread
                        self.userDetails.username = username
                        self.username = username
                    }
//                    print(document.data())
//                    print("This is your username \(self.username)")
//                    print(userDetails?.username)
                }
            }
        }
    }

    
    func getUserId() -> String {
        return Auth.auth().currentUser?.uid ?? "No user id found"
    }
    
    func checkAuth() {
        if Auth.auth().currentUser?.uid != nil {
            getUserDetails()
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }
    }
    
    func showLoginView() {
        showLogin = true
    }
    
    func showSignUpView() {
        showLogin = false
    }
    
    
    func signIn(email: String, password: String) async -> Bool  {
        isBusy = true
        
        do{
            try await Auth.auth().signIn(withEmail: email, password: password)
            isLoggedIn = true
            isBusy = false
            
            return true
        }catch{
            print("Failure \(error.localizedDescription)")
            isBusy = false
            
            return false
        }
        
    }
    
    func createUserInDB(username: String, email: String, userId: String) {
        db
            .collection("users")
            .document(userId)
            .setData([
                "username": username,
                "email": email
            ]) { err in
                if let err = err {
                    print("There was an error writing the document: \(err)")
                } else {
                    print("Document was writed successfully")
                }
            }
    }
    
    func signUp(username: String, email: String, password: String) async -> Bool {
        isBusy = true
        
        do{
            // Built-in FirebaseAuth function to create a user
            let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let user = authDataResult.user
            
            // Adds a new user document to the db
            createUserInDB(username: username, email: email, userId: user.uid)
            
            isLoggedIn = true
            isBusy = false
            
            return true
        }catch {
            print("Failure \(error.localizedDescription)")
            isBusy = false
            
            return false
        }
    }
    
    func signOut() async {
        do {
            try Auth.auth().signOut()
            
            isLoggedIn = false
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}
