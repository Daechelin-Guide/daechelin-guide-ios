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
        $0.delegate = self
    }
    
    private let refreshControl = UIRefreshControl()
    
    private lazy var scrollStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.distribution = .fill
    }
    
    /// menu info container
    private lazy var menuInfoContainer = UIView().then {
        $0.backgroundColor = Color.white
        $0.layer.cornerRadius = 12
        $0.layer.cornerRadius = 12
        $0.layer.shadowRadius = 2
        $0.layer.shadowOpacity = 0.9
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.clipsToBounds = false
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
        $0.settings.fillMode = .half
        $0.settings.updateOnTouch = false
        $0.settings.starSize = 30
        $0.settings.starMargin = 4
        $0.settings.filledImage = UIImage(icon: .filledStar)
        $0.settings.emptyImage = UIImage(icon: .emptyStar)
    }
    
    private lazy var topSeparateLine = UIView()
    
    private lazy var menuLabel = UILabel().then {
        $0.text = "menu"
        $0.textColor = Color.darkGray
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
        $0.setLineSpacing(lineSpacing: 2, alignment: .center)
    }
    
    private lazy var bottomSeparateLine = UIView()
    
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
    
    ///fixed menu info container
    private lazy var fixedMenuInfoContainer = UIView().then {
        $0.backgroundColor = Color.white
        $0.layer.shadowColor = menuInfoContainer.layer.shadowColor
        $0.layer.cornerRadius = 12
        $0.layer.shadowRadius = 2
        $0.layer.shadowOpacity = 0.9
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.maskedCorners = CACornerMask(
            arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner
        )
        $0.clipsToBounds = false
    }
    
    private lazy var bottomShadow = UIView().then { blur in
        let gradientLayer = CAGradientLayer().then {
            $0.frame = CGRect(x: 0, y: 0, width: view.frame.width - 32, height: 24)
            $0.colors = [Color.darkGray.withAlphaComponent(0.3).cgColor,
                         Color.darkGray.withAlphaComponent(0).cgColor]
            $0.startPoint = CGPoint(x: 0.5, y: 0)
            $0.endPoint = CGPoint(x: 0.5, y: 1)
            $0.cornerRadius = 12
            $0.maskedCorners = CACornerMask(
                arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner
            )
        }
        blur.layer.addSublayer(gradientLayer)
    }
    
    private lazy var fixedMenuLabel = UILabel().then {
        $0.textColor = Color.darkGray
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
    }
    
    private lazy var fixedBottomSeparateLine = UIView().then {
        $0.backgroundColor = bottomSeparateLine.backgroundColor
    }
    
    private lazy var fixedKcalLabel = UILabel().then {
        $0.textColor = Color.gray
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
    }
    
    private lazy var fixedNutrientsLabel = UILabel().then {
        $0.textColor = Color.darkGray
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
    }
    
    /// review button
    private lazy var reviewButton = ScaledButton(scale: 0.94).then {
        $0.backgroundColor = Color.white
        $0.layer.cornerRadius = 32
        $0.layer.shadowRadius = 2
        $0.layer.shadowOpacity = 0.9
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    private lazy var reviewButtonImage = UIImageView().then {
        $0.image = UIImage(icon: .review)
        $0.contentMode = .scaleAspectFit
        $0.tintColor = Color.black
    }
    
    /// comment
    private lazy var commentTableView = UITableView().then {
        $0.backgroundColor = Color.background
        $0.register(
            CommentCell.self,
            forCellReuseIdentifier: CommentCell.reuseIdentifier
        )
        $0.isScrollEnabled = false
        $0.allowsSelection = false
        $0.separatorStyle = .none
        $0.delegate = self
    }
    
    private lazy var emptyCommentsLabel = UILabel().then {
        $0.text = "아직 리뷰가 하나도 없어요"
        $0.textColor = Color.darkGray
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textAlignment = .center
    }
    
    private lazy var emptyCommentsSubLabel = UILabel().then {
        $0.text = "직접 리뷰를 작성해 보는 건 어떠신가요??"
        $0.textColor = Color.darkGray
        $0.font = .systemFont(ofSize: 14, weight: .light)
        $0.textAlignment = .center
    }
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        print("\(type(of: self)): \(#function)")
        reactor?.action.onNext(.fetchMenuDetail)
        reactor?.action.onNext(.fetchComments)
    }
    
    // MARK: - UI
    override func setUp() {
        setUIColor()
    }
    
    override func configureVC() {
        scrollView.refreshControl = refreshControl
    }
    
    override func addView() {
        view.addSubview(container)
        /// navigation bar
        container.addSubviews(
            scrollView, bottomShadow, fixedMenuInfoContainer,
            navigationBarView, reviewButton
        )
        navigationBarView.addSubviews(
            navigationBarItemView, navigationBarSeparateLine
        )
        navigationBarItemView.addSubviews(
            backButton, navigationTitle
        )
        scrollView.addSubview(scrollStackView)
        scrollStackView.addArrangedSubviews(
            menuInfoContainer,  emptyCommentsLabel, emptyCommentsSubLabel, commentTableView
        )
        menuInfoContainer.addSubviews(
            menuDateLabel, mealView, starView,
            topSeparateLine, menuLabel, bottomSeparateLine,
            kcalLabel, nutrientsLabel
        )
        fixedMenuInfoContainer.addSubviews(
            fixedMenuLabel, fixedBottomSeparateLine,
            fixedKcalLabel, fixedNutrientsLabel
        )
        reviewButton.addSubview(reviewButtonImage)
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
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        scrollStackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        /// menu info container
        menuInfoContainer.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalTo(nutrientsLabel.snp.bottom).offset(25)
            $0.width.equalToSuperview()
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
        /// fixed menu info container
        fixedMenuInfoContainer.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.bottom.equalTo(fixedNutrientsLabel.snp.bottom).offset(25)
            $0.width.equalTo(scrollView.snp.width).inset(16)
            $0.centerX.equalToSuperview()
        }
        fixedMenuLabel.snp.makeConstraints {
            $0.top.equalTo(fixedMenuInfoContainer.snp.top).offset(20)
            $0.centerX.equalToSuperview()
        }
        fixedBottomSeparateLine.snp.makeConstraints {
            $0.width.equalTo(fixedMenuInfoContainer.snp.width).dividedBy(2)
            $0.top.equalTo(fixedMenuLabel.snp.bottom).offset(20)
            $0.bottom.equalTo(fixedBottomSeparateLine.snp.top).offset(1)
            $0.centerX.equalToSuperview()
        }
        fixedKcalLabel.snp.makeConstraints {
            $0.top.equalTo(fixedBottomSeparateLine.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        fixedNutrientsLabel.snp.makeConstraints {
            $0.top.equalTo(fixedKcalLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        bottomShadow.snp.makeConstraints {
            $0.top.equalTo(fixedMenuInfoContainer.snp.bottom).offset(-12)
            $0.leading.equalTo(fixedMenuInfoContainer.snp.leading)
            $0.centerX.equalToSuperview()
        }
        /// review button
        reviewButton.snp.makeConstraints {
            $0.width.height.equalTo(64)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        reviewButtonImage.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.centerY.centerX.equalToSuperview()
        }
        /// comment
        commentTableView.snp.makeConstraints {
            $0.width.equalTo(scrollView.snp.width).inset(16)
            $0.height.equalTo(100)
            $0.centerX.equalToSuperview()
        }
        emptyCommentsLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        emptyCommentsSubLabel.snp.makeConstraints {
            $0.top.equalTo(emptyCommentsLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setUIColor() {
        guard let type = reactor?.currentState.type else { return }
        let color = Color.getMealColor(for: reactor!.currentState.type)
        
        [menuInfoContainer, reviewButton].forEach {
            $0.layer.shadowColor = color.cgColor
        }
        [bottomSeparateLine, topSeparateLine].forEach {
            $0.backgroundColor = color.withAlphaComponent(0.7)
        }
        mealView.backgroundColor = color
        mealLabel.text = {
            switch type {
                case .TYPE_BREAKFAST: return "조식"
                case .TYPE_LUNCH: return "중식"
                case .TYPE_DINNER: return "석식"
            }
        }()
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
                let menuId = reactor.currentState.menuDetail?.id ?? 0
                let vc = ReviewViewController(reactor: ReviewReactor(menuId: menuId))
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    override func bindAction(reactor: MenuInfoReactor) {
        reactor.action.onNext(.fetchMenuDetail)
        reactor.action.onNext(.fetchComments)
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
        
        reactor.state.map { $0.menuDetail?.totalScore }
            .distinctUntilChanged()
            .map { $0 ?? 0.0 }
            .bind(to: starView.rx.rating)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.menuDetail?.menu }
            .subscribe(onNext: { [weak self] menu in
                let menu = menu?.replacingOccurrences(of: " ", with: "\n")
                self?.menuLabel.text = menu
                self?.fixedMenuLabel.text = menu
                self?.fixedMenuLabel.setLineSpacing(lineSpacing: 2, alignment: .center)
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.menuDetail?.cal }
            .subscribe(onNext: { [weak self] cal in
                self?.kcalLabel.text = cal
                self?.fixedKcalLabel.text = cal
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.menuDetail?.nutrients }
            .subscribe(onNext: { [weak self] nutrients in
                let nutrientsArray = nutrients?.components(separatedBy: ", ")[0...2]
                let replacingNutrients = nutrientsArray?.map {
                    $0.replacingOccurrences(of: "(g)", with: "") + "g"
                }.joined(separator: "\n")
                self?.nutrientsLabel.text = replacingNutrients
                self?.fixedNutrientsLabel.text = replacingNutrients
                self?.fixedNutrientsLabel.setLineSpacing(lineSpacing: 2, alignment: .center)
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.comments }
            .compactMap { $0 }
            .bind(to: commentTableView.rx.items(
                cellIdentifier: CommentCell.reuseIdentifier,
                cellType: CommentCell.self)
            ) { _, comment, cell in
                cell.configuration(comment)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.comments }
            .filter { !($0?.isEmpty ?? true) }
            .subscribe(onNext: { [weak self] comments in
                self?.emptyCommentsLabel.removeFromSuperview()
                self?.emptyCommentsSubLabel.removeFromSuperview()
                
                let commentsCount = comments?.count ?? 0
                self?.commentTableView.snp.updateConstraints {
                    $0.height.equalTo((commentsCount * 70) + 100)
                }
                self?.commentTableView.layoutIfNeeded()
            })
            .disposed(by: disposeBag)

        
    }
}

// MARK: - UIScrollViewDelegate
extension MenuInfoViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let currentPosition = scrollView.contentOffset.y + scrollView.safeAreaInsets.top
        
        if currentPosition >= 155 {
            fixedMenuInfoContainer.isHidden = false
        } else {
            fixedMenuInfoContainer.isHidden = true
            bottomShadow.isHidden = true
        }
        
        if currentPosition >= 180 {
            UIView.animate(withDuration: 0.3) {
                self.bottomShadow.alpha = 1
            }
            bottomShadow.isHidden = false
        } else {
            UIView.animate(withDuration: 0.3) {
                self.bottomShadow.alpha = 0
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension MenuInfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
