//
//  photoCollectionViewCell.swift
//  photoCollection
//
//  Created by yousun on 2021/5/19.
//

import UIKit

class photoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var igImageView: UIImageView!
    
    @IBOutlet weak var cellWidthConstraint: NSLayoutConstraint!
    
    
    static let width = floor((UIScreen.main.bounds.width - 3 * 2) / 3)
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    
        cellWidthConstraint?.constant = photoCollectionViewCell.width
        
    }
    
    
    
    
}
