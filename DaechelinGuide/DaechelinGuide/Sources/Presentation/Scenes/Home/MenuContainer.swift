//
//  MenuContainer.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/2/24.
//

import UIKit

final class MenuContainer: BaseView {
    
    init(
        menu: String?,
        type: MealType
    ) {
        super.init()
        setUI(for: type)
        configure(menu: menu)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(menu: String?) {
        self.menuLabel.text = menu ?? "급식이 없어요."
    }
    
    // MARK: - Properties
    private lazy var container = UIView().then {
        $0.backgroundColor = Color.white
        $0.layer.cornerRadius = 12
        $0.layer.shadowRadius = 2
        $0.layer.shadowOpacity = 0.9
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.clipsToBounds = false
    }

    
    private lazy var foodIcon = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var mealView = UIView().then {
        $0.layer.cornerRadius = 13
        $0.clipsToBounds = true
    }
    
    private lazy var mealLabel = UILabel().then {
        $0.text = "meal"
        $0.textColor = Color.white
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    private lazy var menuLabel = UILabel().then {
        $0.textColor = Color.darkGray
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.numberOfLines = 4
    }
    
    // MARK: - UI
    override func addView() {
        self.addSubview(container)
        container.addSubviews(foodIcon, mealView, menuLabel)
        mealView.addSubview(mealLabel)
    }
    
    override func setLayout() {
        container.snp.makeConstraints {
            $0.height.equalTo(120)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        foodIcon.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(10)
        }
        mealView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(foodIcon.snp.bottom)
            $0.width.equalTo(66)
            $0.bottom.equalToSuperview().offset(-16)
        }
        mealLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.centerX.equalToSuperview()
        }
        menuLabel.snp.makeConstraints {
            $0.leading.equalTo(mealView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setUI(for type: MealType) {
        self.container.layer.shadowColor = Color.getMealColor(for: type).cgColor
        self.mealView.backgroundColor = Color.getMealColor(for: type)
        
        switch type {
        case .TYPE_BREAKFAST:
            self.foodIcon.image = UIImage(icon: .taco)
            self.mealLabel.text = "조식"
        case .TYPE_LUNCH:
            self.foodIcon.image = UIImage(icon: .burger)
            self.mealLabel.text = "중식"
        case .TYPE_DINNER:
            self.foodIcon.image = UIImage(icon: .ramen)
            self.mealLabel.text = "석식"
        }
    }
}
