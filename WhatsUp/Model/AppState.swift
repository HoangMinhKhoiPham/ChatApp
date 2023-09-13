//
//  AppState.swift
//  WhatsUp
//
//  Created by Hoang Minh Khoi Pham on 2023-09-10.
//

import Foundation

enum Route: Hashable {
    case main
    case login
    case signUp
}

class AppState: ObservableObject {
    @Published var routes: [Route] = []
}
