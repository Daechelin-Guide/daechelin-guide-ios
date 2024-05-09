//
//  FadingView.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/9/24.
//

import UIKit

class FadingView: BaseView {
    
    private var position: FadingPosition?
    
    enum FadingPosition {
        case top
        case bottom
    }

    init(
        position: FadingPosition
    ) {
        super.init()
        
        self.position = position
        setupFadeLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupFadeLayer() {
        let fadeLayer = CAGradientLayer()
        fadeLayer.frame = CGRect(x: 0, y: 0, width: bound.width, height: bound.height / 12)
        fadeLayer.colors = [Color.background.withAlphaComponent(0).cgColor,
                            Color.background.withAlphaComponent(0.75).cgColor,
                            Color.background.withAlphaComponent(1).cgColor]
        fadeLayer.startPoint = CGPoint(x: 0.5, y: position == .top ? 1 : 0)
        fadeLayer.endPoint = CGPoint(x: 0.5, y: position == .top ? 0 : 1)
        layer.addSublayer(fadeLayer)
        isUserInteractionEnabled = false
    }
}
