//
//  HomeViewService.swift
//  DemoChatApp
//
//  Created by mehmet karanlık on 23.01.2022.
//

import Foundation
import Firebase
import FirebaseFirestore





struct HomeViewService : HomeViewProtocol {

 var auth: Auth
 var firestore: Firestore


 init() {
  auth = FirebaseAuth.Auth.auth()
  firestore = FirebaseFirestore.Firestore.firestore()
 
 }



 // MARK:  call userName
 func getUserName(completionHandler: @escaping (DocumentSnapshot?, Error?) -> Void) -> Void {
  guard let uid = auth.currentUser?.uid else { return }

  firestore.collection("users").document(uid).getDocument { snapshot, error in
   if let err = error {
    print("Couldnt get username : \(err)")
   }else{
    print("Succesfully got username : \(String(describing: snapshot))")
    guard let data = snapshot?.data() else {return}
    print(data)
   }
   completionHandler(snapshot,error)
  }


 }


 func getUserLogout(completionHandler: @escaping CompletionHandler) {
  do {
  try auth.signOut()
  completionHandler()
  }
  catch {
   print("Error logging out")
  }

 }
}
