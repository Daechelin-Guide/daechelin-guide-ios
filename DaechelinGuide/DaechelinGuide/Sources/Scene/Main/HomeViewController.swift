//
//  HomeViewController.swift
//  DaechelinGuide
//
//  Created by 이민규 on 4/30/24.
//

import UIKit
import RxCocoa
import SnapKit
import Then

final class HomeViewController: BaseVC<HomeViewReactor> {
    
    // MARK: - Properties
    private lazy var container = UIView()
    
    /// navigation bar
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
        $0.tintColor = Color.darkGray
    }
    
    private lazy var settingButton = UIButton().then {
        $0.setImage(UIImage(icon: .setting), for: .normal)
        $0.imageView!.contentMode = .scaleAspectFill
        $0.tintColor = Color.darkGray
    }
    
    private lazy var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = true
        $0.contentInsetAdjustmentBehavior = .always
        $0.clipsToBounds = false
    }
    
    /// calendar button
    private lazy var calendarStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fill
    }
    
    private lazy var yesterdayButton = UIButton().then {
        $0.setImage(UIImage(icon: .leadingArrow), for: .normal)
        $0.imageView?.tintColor = Color.darkGray
    }
    
    private lazy var calendarButton = UIButton().then {
        $0.layer.cornerRadius = 16
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Color.lightGray.cgColor
        $0.backgroundColor = Color.white
    }
    
    private lazy var calendarDateLabel = UILabel().then {
        $0.text = "2023년 12월 25일 (월)"
        $0.textColor = Color.darkGray
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    private lazy var tomorrowButton = UIButton().then {
        $0.setImage(UIImage(icon: .trailingArrow), for: .normal)
        $0.imageView?.tintColor = Color.darkGray
    }
    
    /// menu container
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
        container.addSubviews(
            scrollView, navigationBarView
        )
        navigationBarView.addSubview(navigationBarItemView)
        navigationBarItemView.addSubviews(
            logoImage, rankingButton, settingButton
        )
        scrollView.addSubviews(
            calendarStackView, menuContainerStackView
        )
        calendarStackView.addArrangedSubviews(
            yesterdayButton, calendarButton, tomorrowButton
        )
        calendarButton.addSubview(calendarDateLabel)
        menuContainerStackView.addArrangedSubviews(
            breakfastContainer, lunchContainer, dinnerContainer
        )
    }
    
    override func setLayout() {
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        /// navigation bar
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
        
        /// calendar button
        calendarStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        yesterdayButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
        calendarButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        calendarDateLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(6)
            $0.horizontalEdges.equalToSuperview().inset(14)
        }
        tomorrowButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
        }
        
        /// menu container
        menuContainerStackView.snp.makeConstraints {
            $0.top.equalTo(calendarStackView.snp.bottom).offset(20)
            $0.width.equalTo(scrollView.snp.width).inset(16)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    // MARK: - Reactor
    override func bindView(reactor: HomeViewReactor) {
        
    }
    
    override func bindAction(reactor: HomeViewReactor) {
        yesterdayButton.rx.tap
            .map { Reactor.Action.yesterdayButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        tomorrowButton.rx.tap
            .map { Reactor.Action.tomorrowButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: HomeViewReactor) {
        reactor.state.map { $0.date }
            .distinctUntilChanged()
            .map { "\($0.formattingDate(format: "yyyy년 M월 d일 (E)"))" }
            .bind(to: calendarDateLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
