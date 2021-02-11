//
//  CollectionCell.swift
//  Skynet
//
//  Created by Ios development on 09/02/21.
//  Copyright © 2021 Ios development. All rights reserved.
//

import Foundation
import UIKit

class CollectionCell : UICollectionViewCell{
    
    
    
    let title : UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 20.0)
        view.font = view.font.withSize(20)
        view.numberOfLines = 0
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let id : UILabel = {
        let view = UILabel()
        view.backgroundColor = .gray
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let body : UILabel = {
        let view = UILabel()
        view.sizeToFit()
        view.backgroundColor = .gray
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        
        
        addSubview(title)
        addSubview(id)
        addSubview(body)
        
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant:  -8).isActive = true
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        title.bottomAnchor.constraint(equalTo: id.topAnchor, constant: 0).isActive = true
        //               title.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        id.rightAnchor.constraint(equalTo: self.rightAnchor, constant:  -8).isActive = true
        id.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        id.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8).isActive = true
        id.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        body.rightAnchor.constraint(equalTo: self.rightAnchor, constant:  -8).isActive = true
        body.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        body.topAnchor.constraint(equalTo: id.bottomAnchor, constant: 0).isActive = true
        body.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
      
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
