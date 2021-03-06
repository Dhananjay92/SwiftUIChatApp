 //
 //  SettingsView.swift
 //  DemoChatApp
 //
 //  Created by mehmet karanlık on 24.01.2022.
 //

import SwiftUI
import Lottie
import AudioToolbox

struct SettingsView: View {
 // MARK:  properties
 @ObservedObject var viewModel : SettingsViewModel = SettingsViewModel()
 @ObservedObject var appState : NavigationController

 init() {
  appState = NavigationController.shared
 }


 // MARK:  body




 var body: some View {

   VStack {
      buildBackButton()
      buildImageGroup(viewModel: viewModel)
      DynamicVerticalSpacer(size: 20)
      buildUserInformation()
      buildApplicationInformation()
    buildLogoutButton()
    Spacer()
     }
     .font(.footnote)
     .padding()
     .navigationBarTitleDisplayMode(.inline)
     .fullScreenCover(isPresented: $viewModel.isPresented, onDismiss: viewModel.updateUserPhoto) {
      ImagePicker(image: $viewModel.image)
    }


   }


 fileprivate func buildLogoutButton() -> RoundedRectangleButton {
  RoundedRectangleButton(width: 250, height: 50, foregroundColor: .white, backgroundColor: .red, opacity: 1, shadowApplied: true, buttonTitle: "Sign-Out") {
   viewModel.getUserLoggedOut()

  }
 }

 fileprivate func buildBackButton() -> some View {
  return HStack {
   Button {
    appState.appState = .Home
   } label: {
    Image(systemName: "arrow.backward.circle.fill")
     .font(.title2)
     .foregroundColor(.green)
     .blur(radius: UIConstants.blurRadius)
   }
   DynamicHorizontalSpacer(size: 30)
   Text("What  do you want to do ? ")
    .foregroundColor(.green)
    .font(.title2)
   Spacer()
  }
 }


 fileprivate func buildApplicationInformation() -> some View {
  return GroupBox {
   GroupListTile(leftText: "Application Name:", rightText: "SwiftUI Demo ChatApp")
   GroupListTile(leftText: "Developer:", rightText: "Mehmet Karanlik")
  } label: {
   Text("Application Information")
  }
  .padding()
 }


 fileprivate func buildUserInformation() -> some View {
  return GroupBox {
   GroupListTile(leftText: "Username:", rightText: viewModel.locale.getStringValue(key: LocaleKeys.email).userNameExtract())
   GroupListTile(leftText: "Email:", rightText: viewModel.locale.getStringValue(key: LocaleKeys.email))
   GroupListTile(leftText: "Unique ID:", rightText: viewModel.locale.getStringValue(key: LocaleKeys.userUid))
  } label: {
   Text("User information")
  }
  .padding()
 }


fileprivate func buildImageGroup(viewModel : SettingsViewModel) -> some View {
  return GroupBox {
   buildImage(viewModel: viewModel)
   DynamicVerticalSpacer(size: 20)
   Text("To change image use icon above")
    .font(.caption)
    .foregroundColor(.green)
    .blur(radius: UIConstants.blurRadius)
  } label: {
   Text("Image")
  }
  .padding()
 }


 fileprivate func buildImage(viewModel : SettingsViewModel) -> some View {
  return ZStack(alignment: .bottomTrailing) {
   if viewModel.image == nil {
    AsyncCircularAvatarView(userImageUrl: $viewModel.userImageUrl, radius: 150)
   }else{
    UploadImageButtonView(image: $viewModel.image, isLogin: .constant(false), isAppear: .constant(false),size: 150) {
     
    }
   }
   SimpleUploadButtonView(size: 55) {
    viewModel.isPresented.toggle()
   }

  }
 }

}


// MARK:  preview
struct SettingsView_Previews: PreviewProvider {
 static var previews: some View {
  SettingsView()
 }
}


struct GroupListTile: View {
 let leftText : String
 let rightText : String
 var body: some View {
  HStack {Text(leftText);
   Spacer();
   Text(rightText)
  }
 }
}
