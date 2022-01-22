//
//  MessagePreviewTile.swift
//  DemoChatApp
//
//  Created by mehmet karanlık on 22.01.2022.
//

import SwiftUI

struct MessagePreviewTile: View {
 // MARK:  properties

 let userImageUrl : URL?
 let userName : String
 let tileText : String
 let receiveData : Date



// MARK:  body
 var body: some View {

     HStack(alignment:.top ,spacing:0) {
      DynamicHorizontalSpacer(size: 10)
      AsyncCircularAvatarView(userImageUrl: self.userImageUrl)
      DynamicHorizontalSpacer(size: 20)
      VStack(alignment: .leading, spacing: 0) {
       buildUserInfo()
       DynamicVerticalSpacer(size: 5)
       buildMessageText()
      }
      Spacer()
      Text("34d")
      DynamicHorizontalSpacer(size: 10)
     }
     .padding(.horizontal, 5)
    }


 fileprivate func buildMessageText() -> some View {
  return Text(tileText)
   .font(.subheadline)
   .lineLimit(1)
 }


 fileprivate func buildUserInfo() -> Text {
  return Text(userName)
   .font(.headline)
   .bold()
 }

}



// MARK:  preview
struct MessagePreviewTile_Previews: PreviewProvider {
    static var previews: some View {
     MessagePreviewTile(userImageUrl: nil, userName: "Eddie" ,tileText: "Lorem ipsum Lorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsum" , receiveData: Date.now)
      .previewLayout(.sizeThatFits)

    }
}



