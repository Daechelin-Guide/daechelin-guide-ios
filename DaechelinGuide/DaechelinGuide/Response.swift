//
//  Response.swift
//  DaechelinGuide
//
//  Created by 이민규 on 4/30/24.
//

struct Response<T: Decodable>: Decodable {
    let status: Int
    let message: String
    let data: T
}

struct MessageResponse: Decodable {
    let status: Int
    let message : String
}
