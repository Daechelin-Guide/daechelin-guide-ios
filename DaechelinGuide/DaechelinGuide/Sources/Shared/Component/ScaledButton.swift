//
//  ScaledButton.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/4/24.
//

import UIKit

class ScaledButton: UIButton {
    
    private var defaultBackgroundColor: UIColor?
    private var scale: CGFloat = 0
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15) {
                self.transform = self.isHighlighted
                ? CGAffineTransform(scaleX: self.scale, y: self.scale)
                : .identity
                if self.defaultBackgroundColor != nil {
                    self.backgroundColor = self.isHighlighted
                    ? self.defaultBackgroundColor?.darken(by: 0.1)
                    : self.defaultBackgroundColor
                }
            }
        }
    }
    
    init(
        scale: CGFloat,
        backgroundColor: UIColor? = nil
    ) {
        super.init(frame: .zero)
        
        self.defaultBackgroundColor = backgroundColor
        self.scale = scale
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
