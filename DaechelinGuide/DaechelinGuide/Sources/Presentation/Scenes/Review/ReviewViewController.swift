//
//  ReviewViewController.swift
//  DaechelinGuide
//
//  Created by 이민규 on 4/30/24.
//

import UIKit
import RxCocoa
import SnapKit
import Then
import Cosmos

final class ReviewViewController: BaseVC<ReviewReactor> {
    
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
        $0.text = "급식 리뷰"
        $0.font = .systemFont(ofSize: 18, weight: .medium)
        $0.textColor = Color.black
    }
    
    /// review text view
    private lazy var reviewContainer = UIView().then {
        $0.backgroundColor = Color.white
        $0.layer.cornerRadius = 12
        $0.layer.shadowColor = Color.black.cgColor
        $0.layer.shadowOpacity = 0.02
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 10
    }
    
    private lazy var reviewTextView = UITextView().then {
        $0.font = .systemFont(ofSize: 20, weight: .regular)
        $0.textColor = Color.darkGray
        $0.delegate = self
        $0.isScrollEnabled = false
        textViewDidChange($0)
    }
    
    private lazy var reviewPlaceHolder = UILabel().then {
        $0.text = "리뷰를 작성해주세요."
        $0.font = .systemFont(ofSize: 20, weight: .regular)
        $0.textColor = Color.lightGray
    }
    
    private lazy var reviewTextCountingLabel = UILabel().then {
        $0.text = "0 / 50"
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = Color.darkGray
    }
    
    private lazy var reviewCompleteButton = ScaledButton(scale: 0.95).then {
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.setTitleColor(Color.darkGray, for: .normal)
    }
    
    private lazy var starView = CosmosView().then {
        $0.rating = 0.0
        $0.settings.fillMode = .half
        $0.settings.starSize = 30
        $0.settings.starMargin = 4
        $0.settings.minTouchRating = 0.0
        $0.settings.filledImage = UIImage(icon: .filledStar)
        $0.settings.emptyImage = UIImage(icon: .emptyStar)
    }
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubview(container)
        /// navigation bar
        container.addSubviews(
            starView, reviewContainer, navigationBarView
        )
        navigationBarView.addSubviews(
            navigationBarItemView, navigationBarSeparateLine
        )
        navigationBarItemView.addSubviews(
            backButton, navigationTitle
        )
        reviewContainer.addSubviews(
            reviewTextView, reviewTextCountingLabel, reviewCompleteButton
        )
        reviewTextView.addSubview(reviewPlaceHolder)
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
        /// reivew text view
        reviewContainer.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(20)
            $0.bottom.equalTo(reviewTextView.snp.bottom).offset(54)
            $0.width.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }
        reviewTextView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.height.equalTo(40)
            $0.width.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }
        reviewPlaceHolder.snp.makeConstraints {
            $0.leading.equalTo(reviewTextView).offset(4)
            $0.centerY.equalToSuperview()
        }
        reviewTextCountingLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(22)
        }
        reviewCompleteButton.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.bottom.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(22)
        }
        starView.snp.makeConstraints {
            $0.top.equalTo(reviewContainer.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(26)
        }
    }
    
    // MARK: - Reactor
    override func bindView(reactor: ReviewReactor) {
        backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        reviewCompleteButton.rx.tap
            .subscribe(onNext: {
                let action = ReviewReactor.Action.completeReview
                reactor.action.onNext(action)
            })
            .disposed(by: disposeBag)
        
        reviewTextView.rx.text
            .map { text -> ReviewReactor.Action in
                return .setReviewText(text ?? "")
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        starView.rx.didFinishTouchingCosmos
            .onNext { [weak reactor] score in
                guard let reactor = reactor else { return }
                let action = ReviewReactor.Action.setReviewScore(score)
                reactor.action.onNext(action)
            }
    }
    
    override func bindAction(reactor: ReviewReactor) {
    }
    
    override func bindState(reactor: ReviewReactor) {
        reactor.state.map { $0.reviewText }
            .bind(to: reviewTextView.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.score }
            .bind(to: starView.rx.rating)
            .disposed(by: disposeBag)
    }
}

extension ReviewViewController {
    
    /// keypad down
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true)
    }
}

extension ReviewViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        /// reactive text view
        let size = CGSize(width: self.reviewContainer.frame.width - 32, height: .infinity)
        textView.constraints.forEach {
            if $0.firstAttribute == .height {
                $0.constant = textView.sizeThatFits(size).height
            }
        }
        /// limit the number of review text count
        let textCount = textView.text.count
        let maxCount = 100
        if textCount >= maxCount {
            textView.text = String(textView.text.prefix(maxCount))
            reviewTextCountingLabel.textColor = Color.error
        } else {
            reviewTextCountingLabel.textColor = Color.darkGray
        }
        reviewTextCountingLabel.text = "\(textCount) / \(maxCount)"
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        reviewPlaceHolder.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        reviewPlaceHolder.isHidden = !textView.text.isEmpty
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 100
    }
}
