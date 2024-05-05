//
//  RankingCell.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/5/24.
//

import UIKit
import Then
import SnapKit
import Cosmos

class RankingCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "RankingCell"
    
    private lazy var container = UIView().then {
        $0.backgroundColor = Color.white
        $0.layer.cornerRadius = 12
        $0.layer.shadowRadius = 2
        $0.layer.shadowOpacity = 0.9
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.clipsToBounds = false
    }
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    public func configuration(_ data: Ranking) {
        self.container.layer.shadowColor = Color.getMealColor(for: .TYPE_BREAKFAST).cgColor
    }
    
    func addView() {
        contentView.addSubview(container)
    }
    
    func setLayout() {
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}
