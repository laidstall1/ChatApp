//
//  CustomButton.swift
//  ChatApp
//
//  Created by mac on 21/07/2021.
//

import UIKit

class CustomButton: UIButton {
    
    init(type: ButtonType, title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20 )
        setTitleColor(.white, for: .normal)
        backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        layer.cornerRadius = 5
        setHeight(height: 50)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
