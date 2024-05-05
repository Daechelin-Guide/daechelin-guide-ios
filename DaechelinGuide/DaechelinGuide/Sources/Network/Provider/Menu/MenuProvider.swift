//
//  MenuProvider.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/4/24.
//

import Foundation
import Moya
import RxSwift

final class MenuProvider {
    static let shared = MenuProvider()

    private let wrapper = ProviderWrapper<MenuService>()

    func getMenu(_ date: String) -> Observable<Result<MenuResponse, Error>> {
        return Observable.create { observer in
            self.wrapper.daechelinRequest(target: .getMenu(date), instance: MenuResponse.self) { result in
                switch result {
                case .success(let data):
                    observer.onNext(.success(data))
                    observer.onCompleted()
                case .failure(let error):
                    observer.onNext(.failure(error))
                }
            }
            return Disposables.create()
        }
    }

    
    func getMenuDetail(_ date: String, _ mealType: MealType) -> Observable<Result<MenuDetailResponse, Error>> {
        
        return Observable.create { observer in
            self.wrapper.daechelinRequest(target: .getMenuDatail(date, mealType), instance: MenuDetailResponse.self) { result in
                switch result {
                case .success(let data):
                    observer.onNext(.success(data))
                    observer.onCompleted()
                case .failure(let error):
                    observer.onNext(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
