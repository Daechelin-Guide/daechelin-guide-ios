//
//  HomeViewController.swift
//  DaechelinGuide
//
//  Created by 이민규 on 4/30/24.
//

import UIKit
import RxCocoa
import RxGesture
import SnapKit
import Then

final class HomeViewController: BaseVC<HomeReactor> {
    
    // MARK: - Properties
    private lazy var container = UIView()
    
    /// navigation bar
    private lazy var navigationBarView = UIView().then {
        $0.backgroundColor = Color.white
    }
    
    private lazy var navigationBarSeparateLine = UIView().then {
        $0.backgroundColor = Color.lightGray
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
    
    /// scroll view
    private lazy var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = true
        $0.contentInsetAdjustmentBehavior = .always
        $0.clipsToBounds = false
    }
    
    private let refreshControl = UIRefreshControl()
    
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
        menu: nil, type: .TYPE_BREAKFAST
    )
    
    private lazy var lunchContainer = MenuContainer(
        menu: nil, type: .TYPE_LUNCH
    )
    
    private lazy var dinnerContainer = MenuContainer(
        menu: nil, type: .TYPE_DINNER
    )
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - UI
    override func configureVC() {
        scrollView.refreshControl = refreshControl
    }
    
    override func addView() {
        view.addSubview(container)
        container.addSubviews(
            scrollView, navigationBarView
        )
        navigationBarView.addSubviews(
            navigationBarItemView, navigationBarSeparateLine
        )
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
            $0.height.equalTo(24)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        navigationBarSeparateLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
        logoImage.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(108)
            $0.top.equalTo(navigationBarItemView.snp.top).offset(2)
            $0.leading.equalTo(navigationBarItemView.snp.leading)
        }
        rankingButton.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.trailing.equalTo(settingButton.snp.leading).offset(-10)
        }
        settingButton.snp.makeConstraints {
            $0.height.trailing.equalToSuperview()
        }
        /// scroll view
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
    override func bindView(reactor: HomeReactor) {
        refreshControl.rx.controlEvent(.valueChanged)
            .map { _ in .refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        rankingButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let vc = RankingViewController(reactor: RankingReactor())
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        settingButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let vc = SettingViewController(reactor: SettingReactor())
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        breakfastContainer.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self,
                      reactor.currentState.menu?.breakfast != nil else { return }
                let vc = MenuInfoViewController(
                    reactor: MenuInfoReactor(
                        date: reactor.currentState.date,
                        type: .TYPE_BREAKFAST
                    )
                )
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        lunchContainer.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self,
                      reactor.currentState.menu?.lunch != nil else { return }
                let vc = MenuInfoViewController(
                    reactor: MenuInfoReactor(
                        date: reactor.currentState.date,
                        type: .TYPE_LUNCH
                    )
                )
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        dinnerContainer.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self,
                      reactor.currentState.menu?.dinner != nil else { return }
                let vc = MenuInfoViewController(
                    reactor: MenuInfoReactor(
                        date: reactor.currentState.date,
                        type: .TYPE_DINNER
                    )
                )
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    override func bindAction(reactor: HomeReactor) {
        reactor.action.onNext(.fetchMenu)
        
        yesterdayButton.rx.tap
            .map { Reactor.Action.yesterdayButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        tomorrowButton.rx.tap
            .map { Reactor.Action.tomorrowButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: HomeReactor) {
        reactor.state.map { $0.date }
            .distinctUntilChanged()
            .map { "\($0.formattingDate(format: "yyyy년 M월 d일 (E)"))" }
            .bind(to: calendarDateLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isRefreshing }
            .distinctUntilChanged()
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.menu }
            .subscribe(onNext: { [weak self] menuResponse in
                let breakfast = menuResponse?.breakfast
                let lunch = menuResponse?.lunch
                let dinner = menuResponse?.dinner
                self?.breakfastContainer.configure(menu: breakfast)
                self?.lunchContainer.configure(menu: lunch)
                self?.dinnerContainer.configure(menu: dinner)
            })
            .disposed(by: disposeBag)
    }
}
