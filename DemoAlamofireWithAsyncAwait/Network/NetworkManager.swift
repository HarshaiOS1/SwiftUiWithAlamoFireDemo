//
//  NetworkManager.swift
//  DemoAlamofireWithAsyncAwait
//
//  Created by Krishnappa, Harsha on 28/03/2024.
//

import Foundation
import Alamofire

actor NetworkManager: GlobalActor {
    static let shared = NetworkManager()
    private init() {}
    
    var commonHeaders: HTTPHeaders = ["user_id": "123", "token": "xxx-xx"]
    
    func get(url:String, parameters: Parameters?) async throws -> Data {
        return await withCheckedContinuation { continuation in
            AF.request(url, parameters: parameters, headers: commonHeaders, requestModifier: { $0.timeoutInterval = Constants.timeout})
                .responseData { response in
                    switch(response.result) {
                    case let .success(data):
                        continuation.resume(returning: data)
                    case let .failure(error):
                        continuation.resume(throwing: self.handleError(error: error) as! Never)
                    }
                }
        }
    }
    
    //TODO: handle other errors
    private func handleError(error: AFError) -> Error {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost
            {
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "Unable to connect to the server"
                let currentError = NSError(
                    domain: nserror.domain,
                    code: code,
                    userInfo: userInfo
                )
                return currentError
            }
        }
        return error
    }
}
