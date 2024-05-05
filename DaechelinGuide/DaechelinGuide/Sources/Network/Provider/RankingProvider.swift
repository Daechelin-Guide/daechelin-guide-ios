//
//  RankingProvider.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/5/24.
//

import Foundation
import Moya
import RxSwift

final class RankingProvider {
    static let shared = RankingProvider()
    
    private let wrapper = ProviderWrapper<RankingService>()
    
    func getRating(_ mealType: MealType) -> Observable<Result<RankingResponse, Error>> {
        return Observable.create { observer in
            self.wrapper.daechelinRequest(
                target: .getRanking(mealType),
                instance: RankingResponse.self
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
}
