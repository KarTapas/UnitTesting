//
//  NetworkRequestable.swift
//  LoginPageUnitTesting
//
//  Created by Tapas Kumar Kar on 20/09/23.
//

import Alamofire

protocol NetworkRequestable {
    func request(url: URLConvertible, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?) -> DataRequest
}

extension Session: NetworkRequestable {
    func request(url: URLConvertible, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?) -> DataRequest {
        return self.request(url, method: method, parameters: parameters, headers: headers)
    }
}
