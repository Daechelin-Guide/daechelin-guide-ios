//
//  ProviderWrapper.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/4/24.
//

import Foundation
import Moya

class ProviderWrapper<P: TargetType>: MoyaProvider<P> {
    
    init(
        endpointClosure: @escaping MoyaProvider<P>.EndpointClosure = MoyaProvider.defaultEndpointMapping,
        stubClosure: @escaping MoyaProvider<P>.StubClosure = MoyaProvider.neverStub, callbackQueue: DispatchQueue? = nil,
        plugins: [PluginType] = []
    ) {
        let session = MoyaProvider<P>.defaultAlamofireSession()
        session.sessionConfiguration.timeoutIntervalForRequest = 3
        
        super.init(
            endpointClosure: endpointClosure,
            stubClosure: stubClosure,
            session: session,
            plugins: plugins
        )
    }
    
    func daechelinRequest<Model: Codable>(
        target: P,
        instance: Model.Type,
        completion: @escaping(Result<Model, MoyaError>) -> ()
    ) {
        self.request(target) { result in
            switch result {
            
            case .success(let response):
                if (200 ..< 300).contains(response.statusCode),
                   let data = try? JSONDecoder().decode(instance, from: response.data) {
                    completion(.success(data))
                } else {
                    completion(.failure(.statusCode(response)))
                }
            case .failure(let moyaError):
                completion(.failure(moyaError))
            }
        }
    }
    
    func daechelinSimpleRequest(
        target: P,
        completion: @escaping (Result<Response, MoyaError>) -> Void
    ) {
        self.request(target) { result in
            switch result {
                
            case .success(let response):
                if let data = try? response.map(Data.self) {
                    print(String(data: data, encoding: .utf8)!)
                }
            case .failure(let moyaError):
                print("code: \(moyaError.errorCode)\n", moyaError.localizedDescription)
            }

            completion(result)
        }
    }
    
}
