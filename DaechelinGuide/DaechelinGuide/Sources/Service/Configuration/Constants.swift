//
//  Constants.swift
//  DaechelinGuide
//
//  Created by 이민규 on 4/30/24.
//

import Foundation

public let api: String = {
    let plist = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Info", ofType: "plist")!)
    let value = plist?.object(forKey: "URL") as? String
    return value! + "api/"
}()
