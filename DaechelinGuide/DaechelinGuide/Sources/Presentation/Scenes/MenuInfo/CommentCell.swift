//
//  CommentCell.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/4/24.
//

import UIKit
import Then
import SnapKit

class CommentCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "CommentCell"
    
    var anonymousProfileImageArray: [UIImage] = [.cat, .rabbit, .snake, .elephant, .tiger]
    
    private lazy var anonymousProfileImageView = UIImageView().then {
        $0.image = anonymousProfileImageArray.randomElement()
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var commentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 2
        $0.distribution = .fill
    }
    
    private lazy var anonymousUserName = UILabel().then {
        $0.text = "익명의 대소고인"
        $0.textColor = Color.black
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    private lazy var comment = UILabel().then {
        $0.text = "댓글댓글 댓글댓글 댓글댓글"
        $0.textColor = Color.black
        $0.font = .systemFont(ofSize: 14, weight: .light)
        $0.numberOfLines = 0
    }
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = Color.background
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    public func configuration(_ comment: RatingResponse) {
        self.comment.text = comment.comment
    }
    
    func addView() {
        contentView.addSubviews(
            anonymousProfileImageView, commentStackView
        )
        commentStackView.addArrangedSubviews(
            anonymousUserName, comment
        )
    }
    
    func setLayout() {
        anonymousProfileImageView.snp.makeConstraints {
            $0.width.height.equalTo(46)
            $0.leading.centerY.equalToSuperview()
        }
        commentStackView.snp.makeConstraints {
            $0.leading.equalTo(anonymousProfileImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
