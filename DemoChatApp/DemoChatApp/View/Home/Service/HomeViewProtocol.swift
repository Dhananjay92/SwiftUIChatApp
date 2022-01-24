//
//  IHomeViewService.swift
//  DemoChatApp
//
//  Created by mehmet karanlık on 23.01.2022.
//

import Foundation
import Firebase
import FirebaseFirestore


protocol HomeViewProtocol {
 typealias FirebaseGetCallback = (DocumentSnapshot?,Error?) -> Void
 typealias CompletionHandler =  () ->  Void
 var firestore : Firestore { get }
 var auth : FirebaseAuth.Auth { get }

 init()





 func getUserLogout(completionHandler: @escaping CompletionHandler) -> Void
 func getUserName(completionHandler: @escaping FirebaseGetCallback) -> Void


}
