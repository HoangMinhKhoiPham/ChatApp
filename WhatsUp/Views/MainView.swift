//
//  MainView.swift
//  WhatsUp
//
//  Created by Hoang Minh Khoi Pham on 2023-09-10.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var model: Model
    var body: some View {
        TabView {
            GroupListContainerView()
                .tabItem {
                    Label("Chats", systemImage: "message.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Model())
    }
}
