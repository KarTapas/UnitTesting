//
//  TokenResponse.swift
//  LoginPageUnitTesting
//
//  Created by Tapas Kumar Kar on 19/09/23.
//

struct TokenResponse: Codable {
    let token: String
    let expiresOn: String
    
    func getToken() -> String {
            return token
        }
    func getExpiresOn() -> String {
            return expiresOn
        }
}
