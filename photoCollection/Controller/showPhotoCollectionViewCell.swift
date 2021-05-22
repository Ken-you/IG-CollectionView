//
//  showPhotoCollectionViewCell.swift
//  photoCollection
//
//  Created by yousun on 2021/5/21.
//

import UIKit

class showPhotoCollectionViewCell: UICollectionViewCell {
    
    var ButtonStatus :Bool = false
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var showPhotoImageView: UIImageView!
    @IBOutlet weak var whoLikeLabel: UILabel!
    @IBOutlet weak var showTextView: UITextView!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    // 點選愛心按鈕
    @IBAction func pressLikeBtn(_ sender: Any) {
    
        ButtonStatus = !ButtonStatus
        
        if  ButtonStatus {
            likeButton.setImage(UIImage(named: "iconRedLove"), for: .normal)
        }else{
            likeButton.setImage(UIImage(named: "iconLove"), for: .normal)
        }

    }
        
    
}
