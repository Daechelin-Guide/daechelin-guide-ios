//
//  HomeViewController.swift
//  DaechelinGuide
//
//  Created by 이민규 on 4/30/24.
//

import UIKit
import SnapKit
import Then

final class HomeViewController: BaseVC<HomeViewReactor> {
    
    // MARK: - Properties
    private let container = UIView()
    
    private let navigationBarView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let navigationBarItemView = UIView()
    
    private let logoImage = UIImageView().then {
        $0.image = UIImage(icon: .logo)
        $0.contentMode = .scaleAspectFit
    }
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = true
        $0.contentInsetAdjustmentBehavior = .always
        $0.clipsToBounds = false
    }
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        print("log")
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubview(container)
        container.addSubviews(scrollView, navigationBarView)
        navigationBarView.addSubview(navigationBarItemView)
        navigationBarItemView.addSubviews(logoImage)
    }
    
    override func setLayout() {
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        navigationBarView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(navigationBarItemView.snp.bottom).offset(11)
        }
        navigationBarItemView.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(11)
            $0.horizontalEdges.equalToSuperview().inset(26)
        }
        logoImage.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.leading.equalTo(navigationBarItemView.snp.leading)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(10)
            $0.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Reactor
}
