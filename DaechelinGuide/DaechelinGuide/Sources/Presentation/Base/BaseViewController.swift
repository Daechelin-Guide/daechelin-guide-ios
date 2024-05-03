//
//  BaseViewController.swift
//  DaechelinGuide
//
//  Created by 이민규 on 4/30/24.
//

import UIKit
import ReactorKit

class BaseVC<T: Reactor>: UIViewController {
    
    let bound = UIScreen.main.bounds
    var disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.background
        navigationController?.setNavigationBarHidden(true, animated: true)
        setUp()
        addView()
        setLayout()
        configureVC()
        configureNavigation()
    }
    
    init(reactor: T?) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
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
    func configureVC() { }
    func configureNavigation() { }
    func bindView(reactor: T) { }
    func bindAction(reactor: T) { }
    func bindState(reactor: T) { }
}

extension BaseVC: View {
    
    func bind(reactor: T) {
        bindView(reactor: reactor)
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
}
