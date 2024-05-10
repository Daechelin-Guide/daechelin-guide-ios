//
//  RankingCell.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/5/24.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit
import Cosmos

class RankingCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "RankingCell"
    
    private lazy var container = UIButton().then {
        $0.backgroundColor = Color.white
        $0.layer.cornerRadius = 12
        $0.layer.shadowRadius = 2
        $0.layer.shadowOpacity = 0.9
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.clipsToBounds = false
    }
    
    private lazy var spacer = UIView().then {
        $0.backgroundColor = Color.background
    }
    
    private lazy var crownImage = UIImageView().then {
        $0.image = UIImage(icon: .crown)
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var rankingLabel = UILabel().then {
        $0.text = "1위"
        $0.textColor = Color.breakfast
        $0.font = .systemFont(ofSize: 22, weight: .regular)
    }
    
    private lazy var starView = CosmosView().then {
        $0.settings.fillMode = .half
        $0.settings.updateOnTouch = false
        $0.settings.starSize = 24
        $0.settings.starMargin = 1
        $0.settings.filledImage = UIImage(icon: .filledStar)
        $0.settings.emptyImage = UIImage(icon: .emptyStar)
    }
    
    private lazy var menuLabel = UILabel().then {
        $0.textColor = Color.darkGray
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
    }
    
    private lazy var dateLabel = UILabel().then {
        $0.textColor = Color.lightGray
        $0.font = .systemFont(ofSize: 14, weight: .regular)
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
    public func configuration(_ data: Ranking, _ mealType: MealType) {
        contentView.backgroundColor = Color.background
        let color = Color.getMealColor(for: mealType)
        
        container.layer.shadowColor = color.cgColor
        crownImage.tintColor = color
        rankingLabel.text = "\(data.ranking)위"
        rankingLabel.textColor = color
        starView.rating = data.totalScore
        menuLabel.text = data.menu
        dateLabel.text = data.date.stringToDate(format: "yyyyMMdd").formattingDate(format: "yyyy년 M월 d일 (E)")
    }
    
    func addView() {
        contentView.addSubview(spacer)
        spacer.addSubview(container)
        container.addSubviews(
            crownImage, rankingLabel, starView,
            menuLabel, dateLabel
        )
    }
    
    func setLayout() {
        spacer.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(144)
        }
        container.snp.makeConstraints {
            $0.top.equalTo(spacer.snp.top).inset(2)
            $0.horizontalEdges.equalTo(spacer).inset(2)
            $0.bottom.equalTo(dateLabel.snp.bottom).offset(16)
        }
        crownImage.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.top.equalToSuperview().offset(18)
            $0.leading.equalToSuperview().offset(24)
        }
        rankingLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalTo(crownImage.snp.trailing).offset(8)
        }
        starView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalTo(rankingLabel.snp.trailing).offset(12)
        }
        menuLabel.snp.makeConstraints {
            $0.top.equalTo(rankingLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(menuLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().offset(24)
        }
    }
}
