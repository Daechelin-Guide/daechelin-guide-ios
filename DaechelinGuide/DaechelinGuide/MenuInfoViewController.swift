//
//  MenuInfoViewController.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/2/24.
//

import UIKit
import RxCocoa
import SnapKit
import Then

final class MenuInfoViewController: BaseVC<MenuInfoReactor> {
    
    // MARK: - Properties
    private lazy var container = UIView()
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubview(container)
    }
    
    override func setLayout() {
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Reactor
    override func bindView(reactor: MenuInfoReactor) {
        
    }
    
    override func bindAction(reactor: MenuInfoReactor) {
        
    }
    
    override func bindState(reactor: MenuInfoReactor) {
        
    }
}
