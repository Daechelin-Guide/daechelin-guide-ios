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
import Cosmos

final class MenuInfoViewController: BaseVC<MenuInfoReactor> {
    
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
    
    private lazy var backButton = UIButton().then {
        $0.setImage(UIImage(icon: .leadingArrow), for: .normal)
        $0.imageView!.contentMode = .scaleAspectFit
        $0.tintColor = Color.black
    }
    
    private lazy var navigationTitle = UILabel().then {
        $0.text = "급식 상세 정보"
        $0.font = .systemFont(ofSize: 18, weight: .medium)
        $0.textColor = Color.black
    }
    
    /// scroll view
    private lazy var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = true
        $0.contentInsetAdjustmentBehavior = .always
        $0.clipsToBounds = false
    }
    
    private let refreshControl = UIRefreshControl()
    
    /// menu info container
    private lazy var menuInfoContainer = UIView().then {
        $0.backgroundColor = Color.white
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
    }
    
    private lazy var menuDateLabel = UILabel().then {
        $0.text = "2월 6일 (월)"
        $0.textColor = Color.darkGray
        $0.font = .systemFont(ofSize: 18, weight: .medium)
    }
    
    private lazy var mealView = UIView().then {
        $0.layer.cornerRadius = 14
        $0.clipsToBounds = true
    }
    
    private lazy var mealLabel = UILabel().then {
        $0.text = "meal"
        $0.textColor = Color.white
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    private lazy var starView = CosmosView().then {
        $0.rating = 3.6
        $0.settings.fillMode = .half
        $0.settings.updateOnTouch = false
        $0.settings.starSize = 30
        $0.settings.starMargin = 4
        $0.settings.filledImage = UIImage(icon: .filledStar)
        $0.settings.emptyImage = UIImage(icon: .emptyStar)
    }
    
    private lazy var topSeparateLine = UILabel()
    
    private lazy var menuLabel = UILabel().then {
        $0.text = "menu"
        $0.textColor = Color.darkGray
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
        $0.setLineSpacing(lineSpacing: 2, alignment: .center)
    }
    
    private lazy var bottomSeparateLine = UILabel()
    
    private lazy var kcalLabel = UILabel().then {
        $0.text = "kcal"
        $0.textColor = Color.gray
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
    }
    
    private lazy var nutrientsLabel = UILabel().then {
        $0.text = "nutrients"
        $0.textColor = Color.darkGray
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
        $0.setLineSpacing(lineSpacing: 2, alignment: .center)
    }
    
    /// review button
    private lazy var reviewButton = UIButton().then {
        $0.backgroundColor = Color.white
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
    }
    
    private lazy var reviewButtonLabel = UILabel().then {
        $0.text = "급식 리뷰하기"
        $0.textColor = Color.darkGray
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    private lazy var reviewButtonImage = UIImageView().then {
        $0.image = UIImage(icon: .trailingArrow)
        $0.contentMode = .scaleAspectFit
        $0.tintColor = Color.black
    }
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - UI
    override func setUp() {
        setColor()
    }
    
    override func configureVC() {
        scrollView.refreshControl = refreshControl
    }
    
    override func addView() {
        view.addSubview(container)
        /// navigation bar
        container.addSubviews(
            scrollView, navigationBarView
        )
        navigationBarView.addSubviews(
            navigationBarItemView, navigationBarSeparateLine
        )
        navigationBarItemView.addSubviews(
            backButton, navigationTitle
        )
        scrollView.addSubviews(
            menuInfoContainer, reviewButton
        )
        menuInfoContainer.addSubviews(
            menuDateLabel, mealView, starView,
            topSeparateLine, menuLabel, bottomSeparateLine,
            kcalLabel, nutrientsLabel
        )
        reviewButton.addSubviews(
            reviewButtonLabel, reviewButtonImage
        )
        mealView.addSubview(mealLabel)
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
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        navigationBarSeparateLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
        backButton.snp.makeConstraints {
            $0.height.leading.equalToSuperview()
        }
        navigationTitle.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.leading.equalTo(backButton.snp.trailing).offset(10)
        }
        /// scroll view
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(20)
            $0.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        /// menu info container
        menuInfoContainer.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalTo(nutrientsLabel.snp.bottom).offset(25)
            $0.width.equalTo(scrollView.snp.width).inset(16)
            $0.centerX.equalToSuperview()
        }
        menuDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.bottom.equalTo(menuDateLabel.snp.top).offset(18)
            $0.centerX.equalToSuperview()
        }
        mealView.snp.makeConstraints {
            $0.width.equalTo(66)
            $0.top.equalTo(menuDateLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        mealLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(4)
        }
        starView.snp.makeConstraints {
            $0.top.equalTo(mealView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        topSeparateLine.snp.makeConstraints {
            $0.width.equalTo(menuInfoContainer.snp.width).dividedBy(2)
            $0.top.equalTo(starView.snp.bottom).offset(15)
            $0.bottom.equalTo(topSeparateLine.snp.top).offset(1)
            $0.centerX.equalToSuperview()
        }
        menuLabel.snp.makeConstraints {
            $0.top.equalTo(topSeparateLine.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        bottomSeparateLine.snp.makeConstraints {
            $0.width.equalTo(menuInfoContainer.snp.width).dividedBy(2)
            $0.top.equalTo(menuLabel.snp.bottom).offset(20)
            $0.bottom.equalTo(bottomSeparateLine.snp.top).offset(1)
            $0.centerX.equalToSuperview()
        }
        kcalLabel.snp.makeConstraints {
            $0.top.equalTo(bottomSeparateLine.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        nutrientsLabel.snp.makeConstraints {
            $0.top.equalTo(kcalLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        /// review button
        reviewButton.snp.makeConstraints {
            $0.top.equalTo(menuInfoContainer.snp.bottom).offset(20)
            $0.width.equalTo(scrollView.snp.width).inset(16)
            $0.centerX.equalToSuperview()
        }
        reviewButtonLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(20)
        }
        reviewButtonImage.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setColor() {
        switch reactor?.currentState.type {
        case .TYPE_BREAKFAST:
            let color = Color.breakfast
            menuInfoContainer.layer.borderColor = color.cgColor
            reviewButton.layer.borderColor = color.cgColor
            mealView.backgroundColor = color
            mealLabel.text = "조식"
            bottomSeparateLine.backgroundColor = color.withAlphaComponent(0.7)
            topSeparateLine.backgroundColor = color.withAlphaComponent(0.7)
        case .TYPE_LUNCH:
            let color = Color.lunch
            menuInfoContainer.layer.borderColor = color.cgColor
            reviewButton.layer.borderColor = color.cgColor
            mealView.backgroundColor = color
            mealLabel.text = "중식"
            bottomSeparateLine.backgroundColor = color.withAlphaComponent(0.7)
            topSeparateLine.backgroundColor = color.withAlphaComponent(0.7)
        case .TYPE_DINNER:
            let color = Color.dinner
            menuInfoContainer.layer.borderColor = color.cgColor
            reviewButton.layer.borderColor = color.cgColor
            mealView.backgroundColor = color
            mealLabel.text = "석식"
            bottomSeparateLine.backgroundColor = color.withAlphaComponent(0.7)
            topSeparateLine.backgroundColor = color.withAlphaComponent(0.7)
        case .none:
            return
        }
    }
    
    // MARK: - Reactor
    override func bindView(reactor: MenuInfoReactor) {
        refreshControl.rx.controlEvent(.valueChanged)
            .map { _ in .refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        reviewButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let vc = ReviewViewController(reactor: ReviewReactor())
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    override func bindAction(reactor: MenuInfoReactor) {
        reactor.action.onNext(.fetchMenuDetail)
        
    }
    
    override func bindState(reactor: MenuInfoReactor) {
        reactor.state.map { $0.date }
            .distinctUntilChanged()
            .map { "\($0.formattingDate(format: "M월 d일 (E)"))" }
            .bind(to: menuDateLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isRefreshing }
            .distinctUntilChanged()
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.menuDetail?.menu }
            .distinctUntilChanged()
            .map { $0?.replacingOccurrences(of: " ", with: "\n") }
            .bind(to: menuLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.menuDetail?.cal }
            .distinctUntilChanged()
            .bind(to: kcalLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.menuDetail?.nutrients }
            .distinctUntilChanged()
            .map {
                guard let nutrients = $0 else { return "" }
                let nutrientsArray = nutrients.components(separatedBy: ", ")
                return "\(nutrientsArray[0])\n\(nutrientsArray[1])\n\(nutrientsArray[2])"
            }
            .bind(to: nutrientsLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
}
