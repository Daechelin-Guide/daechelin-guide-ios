//
//  BaseView.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/1/24.
//

import UIKit

class BaseView: UIView {
    
    let bound = UIScreen.main.bounds
    
    init() {
        super.init(frame: .zero)
        setUp()
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func setUp() { }
    func addView() { }
    func setLayout() { }
}
