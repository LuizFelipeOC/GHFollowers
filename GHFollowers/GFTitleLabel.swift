//
//  GFTitleLabel.swift
//  GHFollowers
//
//  Created by Luiz Felipe on 10/11/25.
//

import UIKit

class GFTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false


        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        
    }
    
    private func configure() {
       textColor                        = .label
       adjustsFontSizeToFitWidth        = true
       minimumScaleFactor               = 0.9
       lineBreakMode                    = .byTruncatingTail
        
    }
}
