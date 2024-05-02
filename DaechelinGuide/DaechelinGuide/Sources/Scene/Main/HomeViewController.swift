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
    private lazy var container = UIView()
    
    private lazy var navigationBarView = UIView().then {
        $0.backgroundColor = Color.white
    }
    
    private lazy var navigationBarItemView = UIView()
    
    private lazy var logoImage = UIImageView().then {
        $0.image = UIImage(icon: .logo)
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var rankingButton = UIButton().then {
        $0.setImage(UIImage(icon: .ranking), for: .normal)
        $0.imageView!.contentMode = .scaleAspectFit
        $0.tintColor = Color.black
    }
    
    private lazy var settingButton = UIButton().then {
        $0.setImage(UIImage(icon: .setting), for: .normal)
        $0.imageView!.contentMode = .scaleAspectFill
        $0.tintColor = Color.black
    }
    
    private lazy var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = true
        $0.contentInsetAdjustmentBehavior = .always
        $0.clipsToBounds = false
    }
    
    private lazy var menuContainerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.distribution = .fill
    }
    
    private lazy var breakfastContainer = MenuContainer(
        menu: "들깨계란죽 -감자햄볶음 나박김치 아몬드후레이크+우유 통영식꿀빵",
        type: .TYPE_BREAKFAST
    )
    
    private lazy var lunchContainer = MenuContainer(
        menu: "*브리오슈싸이버거 유부초밥/크래미 미소된장국 모듬야채피클 오렌지주스",
        type: .TYPE_LUNCH
    )
    
    private lazy var dinnerContainer = MenuContainer(
        menu: nil,
        type: .TYPE_DINNER
    )
    
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
