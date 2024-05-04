//
//  MenuProvider.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/4/24.
//

import Foundation
import Moya

final class MenuProvider {
    static let shared = MenuProvider()

    private let wrapper = ProviderWrapper<MenuService>()

    func getMenu(_ date: String, completion: @escaping (Result<MenuResponse, Error>) -> Void) {
        wrapper.daechelinRequest(target: .getMenu(date), instance: MenuResponse.self) {
            switch $0 {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMenuDetail(_ date: String, _ mealType: MealType, completion: @escaping (Result<MenuResponse, Error>) -> Void) {
        wrapper.daechelinRequest(target: .getMenuDatail(date, mealType), instance: MenuResponse.self) {
            switch $0 {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
