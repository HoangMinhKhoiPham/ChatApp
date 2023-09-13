//
//  String+Extension.swift
//  WhatsUp
//
//  Created by Hoang Minh Khoi Pham on 2023-09-09.
//

import Foundation

extension String {
    
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
