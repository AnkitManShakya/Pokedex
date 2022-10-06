//
//  Extensions.swift
//  Pokedex
//
//  Created by Ankit Man Shakya on 02/10/2022.
//

import UIKit

extension UIView {
    
    static var identifier: String  {
         String(describing: self)
    }
    
    func fillSuperView(inset: UIEdgeInsets = .zero) {
        guard let superView = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: inset.left).isActive = true
        self.topAnchor.constraint(equalTo: superView.topAnchor, constant: inset.top).isActive = true
        superView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: inset.right).isActive = true
        superView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: inset.bottom).isActive = true
    }
    
}

extension String {
    func capitalizeFirstLetter() -> String { self.prefix(1).uppercased() + self.lowercased().dropFirst() }
}


