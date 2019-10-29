//
//  SessionStore.swift
//  FHCreative
//
//  Created by Admin on 22/10/2019.
//  Copyright © 2019 MontiRed. All rights reserved.
//

import SwiftUI
import Firebase
import Combine
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class SessionStore : ObservableObject {
    
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session : User? { didSet { self.didChange.send(self) }}
    @Published var profile : UserProfile? { didSet { self.didChange.send(self) }}
    @Published var company : Company? { didSet { self.didChange.send(self) }}
    
    //@Published var newUser = defaults.bool(forKey: "newUser")
   // @Published var hasProfile = defaults.bool(forKey: "hasProfile")
    
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                print("Got user: \(user)")
                self.session = User(
                    uid: user.uid,
                    displayName: user.displayName,
                    email: user.email
                )
                self.getProfile(collectionReference: "users", documentReference: user.uid)
                self.getCompany(collectionReference: "company", documentReference: user.uid)
                
                print(user.uid, user.displayName as Any, user.email as Any)
            } else {
                // if we don't have a user, set our session to nil
                self.session = nil
            }
        }
    }
    
    // additional methods (sign up, sign in) will go here
    func signUp(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
    ) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
        
    }
    
    func signIn(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
    ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            print("Successfully signed out")
            return true
        } catch {
            return false
        }
    }
    
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func addData(params:[String:Any], collectionReference: String!, documentReference: String?) {
        // [START set_document]
        // If documentReference is nil, add document and generate an auto ID
        if documentReference == nil {
            var ref: DocumentReference? = nil
            ref = db.collection(collectionReference).addDocument(data: params) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        } else {
            // If documentReference is not nil, add document with passed reference as ID
            db.collection(collectionReference).document(documentReference!).setData(params) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            // [END set_document]
        }
    }
    
    func getProfile(collectionReference: String, documentReference: String) {
        // [START get_collection]
        let user = session?.uid
        let userData = db.collection(collectionReference).document(documentReference)
        
        userData.addSnapshotListener(includeMetadataChanges: true, listener: { (snapshot, error) in
            if let snapshot = snapshot {
                self.profile = UserProfile(
                    userID: user!,
                    firstname: snapshot.get("firstname") as? String ?? "",
                    lastname: snapshot.get("lastname") as? String ?? "",
                    cellphone: snapshot.get("cellphone") as? String ?? "",
                    dateOfBirth: snapshot.get("dateOfBirth") as? Double ?? 0,
                    town: snapshot.get("town") as? String ?? "",
                    country: snapshot.get("country") as? String ?? "",
                    ratePerHour: snapshot.get("ratePerHour") as? Double ?? 0,
                    userType: snapshot.get("userType") as? String ?? "",
                    rating: snapshot.get("rating") as? Int ?? 0,
                    company: snapshot.get("company") as? String ?? ""
                )
            }
        })
    }
    
    func getCompany(collectionReference: String, documentReference: String) {
        // [START get_collection]

        let companyData = db.collection(collectionReference).document(documentReference)
        
        companyData.addSnapshotListener(includeMetadataChanges: true, listener: { (snapshot, error) in
            if let snapshot = snapshot {
                self.company = Company(
                    companyLogo: snapshot.get("companyLogo") as? String ?? "",
                    companyName: snapshot.get("companyName: String") as? String ?? "",
                    companyTel: snapshot.get("companyTel: String") as? String ?? "",
                    companyEmail: snapshot.get("companyEmail: String") as? String ?? "",
                    companyTown: snapshot.get("companyTown: String") as? String ?? "",
                    companyCity: snapshot.get("companyCity: String") as? String ?? "",
                    companyCountry: snapshot.get("companyCountry: String") as? String ?? "",
                    addedOnDate: snapshot.get("addedOnDate: Double") as? Double ?? 0
                )
                
                print("Snapshot: \(String(describing: snapshot.data()))")

            } else {
                print("Error: \(String(describing: error))")
            }
        })
    }
    
    func snapToArray(collectionReference: String, documentReference: String?){

        var snapshotArray = [String:Any]()

        // [START get_collection]
        let userData = db.collection(collectionReference).document(documentReference!)

        userData.addSnapshotListener(includeMetadataChanges: true) { (snapshot, error) in
            if error == nil {
                //Convert Snap to Array
                for document in snapshot!.data()! {
                    snapshotArray[document.key] = document.value
                }
                print("Array: \(snapshotArray)")
                //Map to JSON

                //let orders = try? JSONDecoder().decode([Company].self, from: snapshot)
                print("Snapshot: \(snapshot)")

            } else {
                print("Error creating snapshotArray: \(String(describing: error))")
            }
        }
    }
}
