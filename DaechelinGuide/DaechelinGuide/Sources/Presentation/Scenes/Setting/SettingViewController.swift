//
//  SettingViewController.swift
//  DaechelinGuide
//
//  Created by 이민규 on 4/30/24.
//

import UIKit
import RxCocoa
import SnapKit
import Then

final class SettingViewController: BaseVC<SettingReactor> {
    
    // MARK: - Properties
    private lazy var container = UIView()
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
    override func bindView(reactor: SettingReactor) {
        
    }
    
    override func bindAction(reactor: SettingReactor) {
    }
    
    override func bindState(reactor: SettingReactor) {
        
    }
}
