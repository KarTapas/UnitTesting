//
//  NetworkRequester.swift
//  LoginPageUnitTesting
//
//  Created by Tapas Kumar Kar on 20/09/23.
//

import Foundation
import Alamofire

class NetworkRequester: NetworkRequestable {
    func performRequest(url: URLConvertible,
                        method: HTTPMethod,
                        parameters: Parameters?,
                        headers: HTTPHeaders?,
                        completion: @escaping (Result<Data, Error>) -> Void) {
        AF.request(url, method: method, parameters: parameters, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
