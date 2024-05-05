//
//  RankingViewController.swift
//  DaechelinGuide
//
//  Created by 이민규 on 4/30/24.
//

import UIKit
import RxCocoa
import SnapKit
import Then

final class RankingViewController: BaseVC<RankingReactor> {
    
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
        $0.text = "대슐랭 랭킹"
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
    
    private lazy var scrollStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.distribution = .fill
    }
    
    /// comment
    private lazy var rankingTableView = UITableView().then {
        $0.backgroundColor = Color.background
        $0.register(
            RankingCell.self,
            forCellReuseIdentifier: RankingCell.reuseIdentifier
        )
        $0.isScrollEnabled = false
        $0.allowsSelection = false
        $0.separatorStyle = .none
    }
    
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - UI
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
        /// scroll view
        scrollView.addSubview(scrollStackView)
        scrollStackView.addArrangedSubviews(
            rankingTableView
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
        /// ranking
        rankingTableView.snp.makeConstraints {
            $0.width.equalTo(scrollView.snp.width).inset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Reactor
    override func bindView(reactor: RankingReactor) {
        backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    override func bindAction(reactor: RankingReactor) {
        reactor.action.onNext(.fetchRanking)
    }
    
    override func bindState(reactor: RankingReactor) {
        reactor.state.map { $0.ranking?.ranking }
            .compactMap { $0 }
            .bind(to: rankingTableView.rx.items(
                cellIdentifier: RankingCell.reuseIdentifier,
                cellType: RankingCell.self)
            ) { _, ranking, cell in
                cell.configuration(ranking)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.ranking?.ranking }
            .subscribe(onNext: { [weak self] comments in
                
                self?.rankingTableView.snp.updateConstraints {
                    $0.height.equalTo(1440)
                }
                self?.rankingTableView.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
    }
}
