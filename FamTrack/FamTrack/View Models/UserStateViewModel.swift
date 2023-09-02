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
    @Published var userId = ""
    
    @Published var selectedGroup: Group = Group(name: "", inviteCode: "")
    @Published var selectedGroupUsers: [User] = []
    var listenerHandles: [ListenerRegistration] = []
    
    @Published var userGroups: [Group] = []
    @Published var options: [DropdownOption] = []
    
    init() {
        userDetails = User()
        checkAuth()
    }
    
    func reset() {
        showLogin = true
        isLoggedIn = false
        isBusy = false
        userDetails = User()
        username = ""
        userId = ""
        selectedGroup = Group(name: "", inviteCode: "")
        selectedGroupUsers = []
        unsubscribeListeners()
        userGroups = []
        options = []
    }
    
    func unsubscribeListeners() {
        listenerHandles.forEach { $0.remove() }
        listenerHandles.removeAll()
    }
    
    func getUserDetails() {
        let userId = getUserId()
        
        db.collection("users").document(userId).getDocument { [weak self] document, error in
            guard let self = self else { return }
            
            if let document = document, document.exists {
                if let userData = try? document.data(as: User.self) {
                    self.userDetails = userData
                    print("The user data should have decoded")
                } else {
                    print(error?.localizedDescription ?? "Problem with decoding document")
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
            print("The user is logged in")
        } else {
            print("The user is not logged in")
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
                "email": email,
                "latitude": 0,
                "longitude": 0,
                "time": Date(),
                "isDriving": false,
                "speed": 0,
//                "topSpeeds": [],
                "totalDistanceDriven": 0
                
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
            
            reset()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    

    
    func getUserGroups() async {
        let groupRef = db.collection("Groups")
        
        print("Your groups will be fetched now")
        
        do {
            let querySnapshot = try await groupRef.whereField("members", arrayContains: getUserId()).getDocuments()
            print("***************************** The groups are being fetched *****************************")
            print("***************** \(getUserId())**********************")
            for document in querySnapshot.documents {
                if let group = try? document.data(as: Group.self) {
                    self.userGroups.append(group)
                    print("Document ID: \(document.documentID) => Data: \(document.data())")
                    print("Hey you sexy man this is all your groups")
                    
                    let groupName = group.name
                    
                    // Append to dropdown options
                    self.options.append(DropdownOption(key: group, val: groupName))
                }
            }
        } catch {
            print("Error getting documents: \(error)")
        }
    }
    
    

    
    func fetchUsersInGroup(group: Group) {
        // Remove all Listeners
        listenerHandles.forEach{$0.remove()}
        listenerHandles.removeAll()
        
        selectedGroupUsers = []
        userGroups = []
        
        let userRef = db.collection("users")
        
        guard let memberIds = group.members else {
            return
        }
        
        for id in memberIds {
            let listener = userRef.document(id).addSnapshotListener { docSnapshot, err in
                guard let doc = docSnapshot else {
                    print("Error fetching document: \(err!)")
                    return
                }
                
                if let user = try? doc.data(as: User.self) {
                    if let index = self.selectedGroupUsers.firstIndex(where: { $0.id == user.id }) {
                        self.selectedGroupUsers[index] = user
                    } else {
                        self.selectedGroupUsers.append(user)
                    }
                }
            }
            
            listenerHandles.append(listener)
        }
    }
}
