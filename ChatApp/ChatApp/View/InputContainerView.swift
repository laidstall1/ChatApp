//
//  InputContainerView.swift
//  ChatApp
//
//  Created by mac on 20/07/2021.
//

import UIKit

class InputContainerView: UIView {
    
    init(textfield: UITextField, image: UIImage?) {
        super.init(frame: .zero)
        
        setHeight(height: 50)
        
        let iv = UIImageView()
        iv.image = image
        iv.tintColor = .white
        iv.alpha = 0.85
        
        addSubview(iv)
        iv.centerY(inView: self)
        iv.anchor(left: leftAnchor, paddingLeft: 8)
        iv.setWidth(width: 28)
        iv.setHeight(height: 24)
         
        addSubview(textfield)
        textfield.centerY(inView: self)
        textfield.anchor(left: iv.rightAnchor, right: rightAnchor, paddingLeft: 8, paddingRight: 0)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        addSubview(dividerView)
        dividerView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 8, height: 0.75)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
