//
//  RatingProvider.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/5/24.
//

import Foundation
import Moya
import RxSwift

final class RatingProvider {
    static let shared = RatingProvider()
    
    private let wrapper = ProviderWrapper<RatingService>()
    
    func getRating(_ menuId: Int) -> Observable<Result<[RatingResponse], Error>> {
        return Observable.create { observer in
            self.wrapper.daechelinRequest(
                target: .getRating(menuId),
                instance: [RatingResponse].self
            ) { result in
                switch result {
                case .success(let data):
                    observer.onNext(.success(data))
                case .failure(let error):
                    observer.onNext(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    
    func postRating(_ menuId: Int, _ request: RatingRequest) -> Observable<Result<Data, Error>> {
        
        return Observable.create { observer in
            self.wrapper.daechelinSimpleRequest(
                target: .postRating(menuId, request)
            ) { result in
                switch result {
                case .success(let data):
                    observer.onNext(.success(data.data))
                case .failure(let error):
                    observer.onNext(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
