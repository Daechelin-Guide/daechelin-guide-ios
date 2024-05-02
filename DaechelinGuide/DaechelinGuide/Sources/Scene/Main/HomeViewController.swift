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
        $0.backgroundColor = Color.white
    }
    
    private let navigationBarItemView = UIView()
    
    private let logoImage = UIImageView().then {
        $0.image = UIImage(icon: .logo)
        $0.contentMode = .scaleAspectFit
    }
    
    private let rankingButton = UIButton().then {
        $0.setImage(UIImage(icon: .ranking), for: .normal)
        $0.imageView!.contentMode = .scaleAspectFit
        $0.tintColor = Color.black
    }
    
    private let settingButton = UIButton().then {
        $0.setImage(UIImage(icon: .setting), for: .normal)
        $0.imageView!.contentMode = .scaleAspectFill
        $0.tintColor = Color.black
    }
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = true
        $0.contentInsetAdjustmentBehavior = .always
        $0.clipsToBounds = false
    }
    
    private let menuContainerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.distribution = .fill
    }
    
    private let breakfastContainer = MenuContainer(type: .TYPE_BREAKFAST)
    
    private let lunchContainer = MenuContainer(type: .TYPE_LUNCH)
    
    private let dinnerContainer = MenuContainer(type: .TYPE_DINNER)
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubview(container)
        container.addSubviews(scrollView, navigationBarView)
        navigationBarView.addSubview(navigationBarItemView)
        navigationBarItemView.addSubviews(logoImage, rankingButton, settingButton)
        scrollView.addSubview(menuContainerStackView)
        menuContainerStackView.addArrangedSubviews(
            breakfastContainer, lunchContainer, dinnerContainer
        )
    }
    
    override func setLayout() {
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        navigationBarView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(navigationBarItemView.snp.bottom).offset(16)
        }
        navigationBarItemView.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        logoImage.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(120)
            $0.top.equalTo(navigationBarItemView.snp.top).offset(2)
            $0.leading.equalTo(navigationBarItemView.snp.leading)
        }
        rankingButton.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.trailing.equalTo(settingButton.snp.leading).offset(-10)
        }
        settingButton.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.trailing.equalTo(navigationBarItemView.snp.trailing)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(34)
            $0.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        menuContainerStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width).inset(16)
            $0.verticalEdges.equalToSuperview()
        }
    }
    
    // MARK: - Reactor
}
