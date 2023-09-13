//
//  Image+Extension.swift
//  WhatsUp
//
//  Created by Hoang Minh Khoi Pham on 2023-09-11.
//

import Foundation
import SwiftUI

extension Image {
    func rounded(width: CGFloat = 100, height: CGFloat = 100) -> some View {
        return self.resizable()
            .frame(width: width, height: height)
            .clipShape(Circle())
    }
}
