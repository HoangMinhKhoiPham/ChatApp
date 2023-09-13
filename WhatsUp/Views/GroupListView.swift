//
//  GroupListView.swift
//  WhatsUp
//
//  Created by Hoang Minh Khoi Pham on 2023-09-10.
//

import SwiftUI

struct GroupListView: View {
    let groups: [Group]
    var body: some View {
        List(groups) { group in
            
            NavigationLink{
                GroupDetailView(group: group)
            } label: {
                HStack {
                    Image(systemName: "person.2")
                    Text(group.subject)
                } //: HSTACK
            }
            
        } //: LIST
    }
}

struct GroupListView_Previews: PreviewProvider {
    static var previews: some View {
        GroupListView(groups: [])
    }
}
