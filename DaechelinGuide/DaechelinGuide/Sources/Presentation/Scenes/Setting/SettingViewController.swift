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
import StoreKit

final class SettingViewController: BaseVC<SettingReactor> {
    
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
        $0.text = "설정"
        $0.font = .systemFont(ofSize: 18, weight: .medium)
        $0.textColor = Color.black
    }
    
    /// setting
    private lazy var settingButtonStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.distribution = .fill
    }
    
    private lazy var privacyPolicyButton = ScaledButton(
        scale: 0.98, backgroundColor: Color.white
    ).then {
        $0.layer.cornerRadius = 8
    }
    
    private lazy var privacyPolicyContainerLeadingItem = UILabel().then {
        $0.text = "개인정보 처리방침"
        $0.textColor = Color.black
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    private lazy var privacyPolicyContainerTrailingItem = UIImageView().then {
        $0.image = UIImage(icon: .trailingArrow)
        $0.contentMode = .scaleAspectFit
        $0.tintColor = Color.black
    }
    
    private lazy var deleteReviewButton = ScaledButton(
        scale: 0.98, backgroundColor: Color.white
    ).then {
        $0.layer.cornerRadius = 12
    }
    
    private lazy var deleteReviewLeadingItem = UILabel().then {
        $0.text = "작성한 리뷰 삭제 요청"
        $0.textColor = Color.black
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    private lazy var deleteReviewTrailingItem = UIImageView().then {
        $0.image = UIImage(icon: .trailingArrow)
        $0.contentMode = .scaleAspectFit
        $0.tintColor = Color.black
    }
    
    private lazy var appVersionButton = ScaledButton(
        scale: 0.98, backgroundColor: Color.white
    ).then {
        $0.layer.cornerRadius = 12
    }
    
    private lazy var appVersionLeadingItem = UILabel().then {
        $0.text = "앱 버전"
        $0.textColor = Color.black
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    private lazy var appVersionTrailingItem = UILabel().then {
        $0.text = appVersion
        $0.textColor = Color.error
        $0.font = .systemFont(ofSize: 15, weight: .regular)
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
            settingButtonStackView, navigationBarView
        )
        navigationBarView.addSubviews(
            navigationBarItemView, navigationBarSeparateLine
        )
        navigationBarItemView.addSubviews(
            backButton, navigationTitle
        )
        /// setting
        settingButtonStackView.addArrangedSubviews(
            privacyPolicyButton, deleteReviewButton, appVersionButton
        )
        privacyPolicyButton.addSubviews(
            privacyPolicyContainerLeadingItem, privacyPolicyContainerTrailingItem
        )
        deleteReviewButton.addSubviews(
            deleteReviewLeadingItem, deleteReviewTrailingItem
        )
        appVersionButton.addSubviews(
            appVersionLeadingItem, appVersionTrailingItem
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
        /// setting
        settingButtonStackView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        privacyPolicyButton.snp.makeConstraints {
            $0.top.equalTo(settingButtonStackView.snp.top)
            $0.height.equalTo(50)
            $0.width.equalToSuperview()
        }
        privacyPolicyContainerLeadingItem.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        privacyPolicyContainerTrailingItem.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        deleteReviewButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalToSuperview()
        }
        deleteReviewLeadingItem.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        deleteReviewTrailingItem.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        appVersionButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalToSuperview()
        }
        appVersionLeadingItem.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        appVersionTrailingItem.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Reactor
    override func bindView(reactor: SettingReactor) {
        backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        privacyPolicyButton.rx.tap
            .subscribe(onNext: { _ in
                if let url = URL(string: "https://min-gyu.notion.site/43f3fa6077c346c692359f790d79cd7a?pvs=74") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            })
            .disposed(by: disposeBag)
        
        deleteReviewButton.rx.tap
            .subscribe(onNext: { _ in
                let subjectEncoded = "[대슐랭 가이드] 리뷰 삭제 요청".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                let bodyEncoded = "예시 20240101 / 점심 / 내용 -> 삭제 부탁드립니다".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                let mailtoString = "mailto:dev.gyuuu@gmail.com?subject=\(subjectEncoded)&body=\(bodyEncoded)"
                if let mailtoURL = URL(string: mailtoString), UIApplication.shared.canOpenURL(mailtoURL) {
                    UIApplication.shared.open(mailtoURL, options: [:], completionHandler: nil)
                }
            })
            .disposed(by: disposeBag)
        
        appVersionButton.rx.tap
            .subscribe(onNext: { _ in
                SKStoreReviewController.requestReview()
            })
            .disposed(by: disposeBag)
    }
    
    override func bindAction(reactor: SettingReactor) {
    }
    
    override func bindState(reactor: SettingReactor) {
        
    }
}
