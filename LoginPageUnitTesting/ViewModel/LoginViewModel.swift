

import Foundation
import Alamofire

class LoginViewModel: ObservableObject {
    @Published var token: String
    @Published var expiresOn: String
    @Published var isLoggedIn: Bool

    init() {
        self.token = ""
        self.expiresOn = ""
        self.isLoggedIn = false
    }

    func login(username: String, password: String) {
        let authString = "\(username):\(password)"
        guard let authData = authString.data(using: .utf8)?.base64EncodedString() else {
            return
        }

        let headers: HTTPHeaders = [
            "X-Nspire-AppToken": "f07740dc-1252-48f3-9165-c5263bbf373c",
            "Authorization": "Basic \(authData)"
        ]

        AF.request("https://identity-stage.spireon.com/identity/token", method: .get, headers: headers)
            .validate()
            .responseDecodable(of: TokenResponse.self) { [weak self] response in
                switch response.result {
                case .success(let tokenResponse):
                    self?.token = tokenResponse.token
                    self?.expiresOn = tokenResponse.expiresOn
                    self?.isLoggedIn = true

                case .failure(let error):
                    print(error)
                    self?.isLoggedIn = false
                }
            }
    }
}



