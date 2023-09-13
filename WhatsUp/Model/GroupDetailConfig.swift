//
//  GroupDetailConfig.swift
//  WhatsUp
//
//  Created by Hoang Minh Khoi Pham on 2023-09-12.
//

import Foundation
import SwiftUI
struct GroupDetailConfig {
    
    var chatText: String = ""
    var sourceType: UIImagePickerController.SourceType?
    var selectedImage: UIImage?
    var showOptions: Bool = false
    
    mutating func clearForm() {
        chatText = ""
        selectedImage = nil
    }
    var isValid: Bool {
        !chatText.isEmptyOrWhiteSpace || selectedImage != nil
    }
}
