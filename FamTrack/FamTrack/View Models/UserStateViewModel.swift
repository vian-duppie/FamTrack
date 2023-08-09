//
//  UserStateViewModel.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/09.
//

import Foundation
import Firebase

@MainActor
class UserStateViewModel: ObservableObject {
    
    @Published var isLoggedIn = false
    @Published var isBusy = false
    
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
    
    func signUp(username: String, email: String, password: String) async -> Bool {
        return true
    }
    
    func signOut() async -> Result<Bool, Error>  {
        isBusy = true
        do{
            try await Task.sleep(nanoseconds: 1_000_000_000)
            isLoggedIn = false
            isBusy = false
            return .success(true)
        }catch{
            isBusy = false
            return .failure(error)
        }
    }
}
