//
//  ChatMessageListView.swift
//  WhatsUp
//
//  Created by Hoang Minh Khoi Pham on 2023-09-11.
//

import SwiftUI
import FirebaseAuth
struct ChatMessageListView: View {
    // MARK: - PROPERTY
    let chatMessages: [ChatMessage]
    
    // MARK: - FUNCTION
    private func isChatMessageFromCurrentUser(_ chatMessage: ChatMessage) -> Bool {
        guard let currentUser = Auth.auth().currentUser else {
            return false
        }
        return currentUser.uid == chatMessage.uid
    }
    // MARK: - BODY
    var body: some View {
        ScrollView {
            VStack{
                ForEach(chatMessages) { chatMessage in
                    VStack {
                        if isChatMessageFromCurrentUser(chatMessage) {
                            HStack {
                                Spacer()
                                ChatMessageView(chatMessage: chatMessage, direction: .right, color: .blue)
                            } //: HSTACK
                        } //: CONDITION
                        else {
                            HStack {
                                ChatMessageView(chatMessage: chatMessage, direction: .left, color: .gray)
                                Spacer()
                            } //: HSTACK
                        }
                        Spacer().frame(height: 20)
                            .id(chatMessage.id)
                    } //: VSTACK
                    .listRowSeparator(.hidden)
                } //: LOOP
            } //: VSTACK
        } //: SCROLLVIEW
        .padding([.bottom], 60)
    }
}

struct ChatMessageListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageListView(chatMessages: [])
    }
}
