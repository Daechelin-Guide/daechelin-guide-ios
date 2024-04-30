//
//  ViewController.swift
//  DaechelinGuide
//
//  Created by 이민규 on 4/30/24.
//

import UIKit
import SnapKit
import Then

class VC: UIViewController {
    
    let image = UIImageView().then {
        $0.image = UIImage(named: "burger")
        $0.contentMode = .scaleAspectFit
    }
    
    let testText: UILabel = {
        let text = UILabel()
        text.text = api
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(image)
        view.addSubview(testText)

        self.view.backgroundColor = .green
        
        testText.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        image.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(testText.snp.top).offset(-20)
            $0.width.equalTo(200)
            $0.height.equalTo(100)
        }
        
    }
}
