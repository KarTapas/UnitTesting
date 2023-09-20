

import Foundation
import Alamofire
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var tokenResponse: TokenResponse?
    @Published var isLoggedIn: Bool = false
    
    func getToken(username: String, password: String, completion: @escaping (Bool) -> Void) {
        let basicAuth = "\(username):\(password)"
        let base64Auth = Data(basicAuth.utf8).base64EncodedString()
        let headers: HTTPHeaders = [
            "X-Nspire-AppToken": "f07740dc-1252-48f3-9165-c5263bbf373c",
            "Authorization": "Basic \(base64Auth)"
        ]
        AF.request("https://identity-stage.spireon.com/identity/token", method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: TokenResponse.self) { response in
                switch response.result {
                case .success(let tokenResponse):
                    self.tokenResponse = tokenResponse
                    if !tokenResponse.token.isEmpty && !tokenResponse.expiresOn.isEmpty {
                                      self.tokenResponse = tokenResponse
                       print(tokenResponse.expiresOn)
                                      completion(true)
                        self.isLoggedIn = true
                                  }
                case .failure:
                    completion(false)
                    self.isLoggedIn = true
                }
            }
    }
}
