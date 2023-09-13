//
//  GroupListContainerView.swift
//  WhatsUp
//
//  Created by Hoang Minh Khoi Pham on 2023-09-10.
//

import SwiftUI

struct GroupListContainerView: View {
    @State private var isPresented: Bool = false
    @EnvironmentObject private var model: Model
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isPresented = true
                } label: {
                    Text("NewGroup")
                }
            } //: HSTACK
            
            GroupListView(groups: model.groups)
            
            Spacer()
        } //: VSTACK
        .task {
            do {
                try await model.populateGroup()
            } catch {
                print(error)
            }
        }
        .padding()
        .sheet(isPresented: $isPresented) {
            AddNewGroupView()
        }
    }
}

struct GroupListContainerView_Previews: PreviewProvider {
    static var previews: some View {
        GroupListContainerView()
            .environmentObject(Model())
    }
}
