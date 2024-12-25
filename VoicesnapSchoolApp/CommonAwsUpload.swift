//
//  CommonAwsUpload.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 25/12/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper
class AWSUploadManager {
    static let shared = AWSUploadManager()
    
    private init() {} // Prevent external initialization

    func uploadImageToAWS(image: UIImage, presignedURL: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.9),
              let url = URL(string: presignedURL) else {
            completion(.failure(NSError(domain: "InvalidInput", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid image or URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")

        let uploadTask = URLSession.shared.uploadTask(with: request, from: imageData) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                completion(.success(presignedURL)) // Returning the presigned URL as confirmation
            } else {
                let uploadError = NSError(domain: "UploadError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed with an unexpected response"])
                completion(.failure(uploadError))
            }
        }

        uploadTask.resume()
    }
    
    
    func uploadPDFAWSUsingPresignedURL(pdfData: Data, presignedURL: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Validate URL
        guard let url = URL(string: presignedURL) else {
            completion(.failure(NSError(domain: "InvalidInput", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        // Create a URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/pdf", forHTTPHeaderField: "Content-Type")

        // Use URLSession to upload the PDF
        let uploadTask = URLSession.shared.uploadTask(with: request, from: pdfData) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("PDF Upload successful!")
                completion(.success(presignedURL)) // Returning the presigned URL as confirmation
            } else {
                let uploadError = NSError(domain: "UploadError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed with an unexpected response"])
                completion(.failure(uploadError))
            }
        }

        // Start the upload task
        uploadTask.resume()
    }
}



class AWSPreSignedURL {
    static let shared = AWSPreSignedURL()

    private init() {} // Prevent external initialization

    func fetchPresignedURL(bucket: String, fileName: URL, SchoolId: String, fileType: String, completion: @escaping (Result<AwsResps, Error>) -> Void) {
        
        let currentDate = getCurrentDateString()
        let param: [String: Any] = [
            "bucket": bucket,
            "fileName": fileName.absoluteString,
            "bucketPath": currentDate + "/" + SchoolId,
            "fileType": fileType
        ]

        AwsReq.call_request(param: param) { res in
            if let awsImage = Mapper<AwsResps>().map(JSONString: res) {
                if awsImage.status == 1 {
                    completion(.success(awsImage))
                } else {
                    let error = NSError(domain: "AWSFetchError", code: 0, userInfo: [NSLocalizedDescriptionKey: awsImage.message ?? "Unknown error"])
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "AWSFetchError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse response"])
                completion(.failure(error))
            }
        }
    }
    
    
    func getCurrentDateString(format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date())
    }
}
