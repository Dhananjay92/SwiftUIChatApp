 //
 //  HomeView.swift
 //  DemoChatApp
 //
 //  Created by mehmet karanlık on 22.01.2022.
 //

import SwiftUI

struct HomeView: View {
  // MARK:  properties
 @ObservedObject var viewModel : HomeViewModel = HomeViewModel()
 let width : CGFloat = UIScreen.main.bounds.width
 let height : CGFloat = UIScreen.main.bounds.height
 
 
  // MARK:  body
 var body: some View {

   
  NavigationView {
   ZStack(alignment:.bottom) {

     buildMessages()

     RoundedRectangleButton(width:  width * 0.8, height: 40, foregroundColor: .white, backgroundColor: .green, opacity: 1, shadowApplied: true, buttonTitle: "+ New Message") {

     }
     .padding(.bottom ,20)
    }
   .navigationBarModifiers(viewModel: self.viewModel)
  }
 }
 
 fileprivate func buildMessages() ->  some View {
  return ScrollView {
   VStack {
    ForEach(0...2, id : \.self) { item in
     MessagePreviewTile(userImageUrl: nil, userName: "Eddie", tileText: "Lorem ipsum", receiveData: Date.now)
    }
    
    DynamicVerticalSpacer(size: 70)
   }
   
  }
  
  
 }
 
}

 // MARK:  preview
struct HomeView_Previews: PreviewProvider {
 static var previews: some View {
  HomeView()
  
 }
}




 // MARK:  extensions
fileprivate extension ZStack  {
 
 
 func navigationBarModifiers(viewModel: HomeViewModel) -> some View {
  self
   .navigationTitle("Messages")
   .navigationBarTitleDisplayMode(.automatic)
   .navigationBarItems(leading: HStack{
    AsyncCircularAvatarView(userImageUrl: viewModel.user.userImageUrl, radius: 40)

    Text(viewModel.user.userName!)
   }, trailing: buildTrailingButton(viewModel: viewModel))
   .ignoresSafeArea(edges: .bottom)
 }
 
 
 func buildTrailingButton(viewModel : HomeViewModel) -> some View {
  return NavigationLink {
   SettingsView()
  } label: {
   Image(systemName: "gear")
    .font(.system(size: 24, weight: .bold))
    .foregroundColor(.green)
    .blur(radius: UIConstants.blurRadius)
  }

 }
}
