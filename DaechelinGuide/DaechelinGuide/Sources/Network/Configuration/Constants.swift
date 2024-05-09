//
//  Constants.swift
//  DaechelinGuide
//
//  Created by 이민규 on 4/30/24.
//

import Foundation

public let apiUrl: String = {
    let plist = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Info", ofType: "plist")!)
    return (plist?.object(forKey: "URL") as? String)!
}()

public let appVersion: String = {
    return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!
}()
