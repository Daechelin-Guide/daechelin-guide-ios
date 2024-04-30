//
//  Response.swift
//  DaechelinGuide
//
//  Created by 이민규 on 4/30/24.
//

class Response<T: Decodable>: Decodable {
    var status: Int
    var message: String
    var data: T
}

class MessageResponse: Decodable {
    var status: Int
    var message : String
}
