//
//  MainViewController.swift
//  DaechelinGuide
//
//  Created by 이민규 on 4/30/24.
//

import UIKit
import SnapKit
import Then

final class MainViewController: BaseVC<MainViewReactor> {
    
    // MARK: - Properties
    private let rootView = UIView()
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubview(rootView)
    }
    
    override func setLayout() {
        rootView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Reactor
}
