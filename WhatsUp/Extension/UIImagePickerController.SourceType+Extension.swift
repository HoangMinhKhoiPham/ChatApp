//
//  UIImagePickerController.SourceType+Extension.swift
//  WhatsUp
//
//  Created by Hoang Minh Khoi Pham on 2023-09-11.
//

import Foundation
import SwiftUI

extension UIImagePickerController.SourceType: Identifiable {
    public var id: Int {
        switch self {
        case .camera:
            return 1
        case .photoLibrary:
            return 2
        case .savedPhotosAlbum:
            return 3
        @unknown default:
            return 4
        }
    }
}

