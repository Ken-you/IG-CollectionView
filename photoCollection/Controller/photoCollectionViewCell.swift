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
    
    // 主頁底下貼文，分成一列三張圖
    static let width = floor((UIScreen.main.bounds.width - 3 * 2) / 3)
    
    // Cell 的寬度等於Cell內容的寬度
    override func awakeFromNib() {
        
        super.awakeFromNib()
    
        cellWidthConstraint?.constant = photoCollectionViewCell.width
        
    }
    
    
    
    
}
