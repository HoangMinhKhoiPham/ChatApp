//
//  Storage+Extension.swift
//  WhatsUp
//
//  Created by Hoang Minh Khoi Pham on 2023-09-12.
//

import Foundation
import FirebaseStorage

enum FirebaseStorageBuckets: String {
    case photos
    case attachments
}

extension Storage {
    func updateData(for key: String, data: Data, bucket: FirebaseStorageBuckets) async throws -> URL {
        
        let storageRef = Storage.storage().reference()
        let photoRef = storageRef.child("\(bucket.rawValue)/\(key).png")
        
        let _ = try await photoRef.putDataAsync(data)
        let downloadURL = try await photoRef.downloadURL()
        return downloadURL
    }
}
