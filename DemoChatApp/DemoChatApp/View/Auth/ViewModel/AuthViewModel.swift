 //
 //  AuthViewModel.swift
 //  DemoChatApp
 //
 //  Created by mehmet karanlık on 21.01.2022.
 //

import Foundation
import Firebase
import UIKit
import SwiftUI


class AuthViewModel : ObservableObject {
  // MARK:  instances
 let service : AuthViewService
 let localeManager : LocaleManager
 let appState: NavigationController


 init() {
  localeManager = LocaleManager.shared
  service = AuthViewService.shared
  appState = NavigationController.shared
 }




  // MARK:  Variables
  // image variable
 @Published var image : UIImage?


  // bools
 @Published var isLoading : Bool = false
 @Published var isLogin : Bool = true
 @Published var isAppear : Bool  = false
 @Published var isPresented : Bool = false
 @Published var isSnackBarShown : Bool = false


  // textfield variables

 @Published var email : String = ""
 @Published var password : String = ""
 @Published var passwordConfirm : String = ""





  // MARK:  Functions

  // Firebase Callbacks
 func createAccount()   -> Void {
  self.isLoading = true
  service.createNewAccount(email: self.email, password: self.password, passwordConfirm: self.passwordConfirm, image: image, completionHandler: {
   self.loginUser()
  })

 }

 func loginUser()  -> Void {

  self.isLoading = true
  LocaleManager.shared.setStringValue(key: LocaleKeys.userPassword, value: self.password)
  LocaleManager.shared.setStringValue(key: LocaleKeys.email, value: self.email)
  service.loginUser(email: email, password: password) {
   let range = self.email.range(of: "@")?.lowerBound
   let cacheData = String(self.email.prefix(upTo: range ?? String.Index(utf16Offset: 5, in: "asdadsadasd")))
   self.localeManager.setStringValue(key: LocaleKeys.username, value: cacheData)
   print("onay")
   self.isLoading = false
   self.appState.appState = .Home
  }errorHandler: {
   self.isLoading = false
   self.showSnackBar()

  }
 }




 func showSnackBar() {
   self.isSnackBarShown = true
 }




  // util functions

 func clearCredentials() {
  password.removeAll()
  email.removeAll()
  passwordConfirm.removeAll()
  image = nil
 }
 

}

