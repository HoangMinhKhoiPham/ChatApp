//
//  ChatMessageInputView.swift
//  WhatsUp
//
//  Created by Hoang Minh Khoi Pham on 2023-09-12.
//

import SwiftUI

struct ChatMessageInputView: View {
    @Binding var groupDetailConfig: GroupDetailConfig
    var onSendMessage: () -> Void
    @FocusState var isChatTextFieldFocused: Bool
    
    var body: some View {
        HStack {
            Button {
                groupDetailConfig.showOptions = true
            } label: {
                Image(systemName: "plus")
            }
            TextField("Enter text here", text: $groupDetailConfig.chatText)
                .textFieldStyle(.roundedBorder)
                .focused($isChatTextFieldFocused)
            
            Button {
                if groupDetailConfig.isValid {
                    onSendMessage()
                }

            } label: {
                Image(systemName: "paperplane.circle.fill")
                    .font(.largeTitle)
                    .rotationEffect(Angle(degrees: 44))
            }

        }
    }
}

struct ChatMessageInputView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageInputView(groupDetailConfig: .constant(GroupDetailConfig(chatText: "hello world!")), onSendMessage: { })
    }
}
