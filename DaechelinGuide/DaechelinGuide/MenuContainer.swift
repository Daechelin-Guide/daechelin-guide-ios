//
//  MenuContainer.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/2/24.
//

import UIKit

final class MenuContainer: BaseView {
    
    init(
        type: MealType
    ) {
        super.init()
        self.container.layer.borderColor = primaryColor(for: type).cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    private let container = UIView().then {
        $0.backgroundColor = Color.white
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.clipsToBounds = true
    }
    
    // MARK: - UI
    
    override func addView() {
        self.addSubview(container)
    }
    
    override func setLayout() {
        // test
        container.snp.makeConstraints {
            $0.height.equalTo(120)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    private func primaryColor(for type: MealType) -> UIColor {
        switch type {
        case .TYPE_BREAKFAST:
            return Color.breakfast
        case .TYPE_LUNCH:
            return Color.lunch
        case .TYPE_DINNER:
            return Color.dinner
        }
    }
}
