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

final class ReviewViewController: BaseVC<ReviewReactor> {
    
    // MARK: - Properties
    private lazy var container = UIView()
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubview(container)
    }
    
    override func setLayout() {
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Reactor
    override func bindView(reactor: ReviewReactor) {
        
    }
    
    override func bindAction(reactor: ReviewReactor) {
    }
    
    override func bindState(reactor: ReviewReactor) {
        
    }
}
