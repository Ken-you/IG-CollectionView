//
//  showPhotoCollectionViewController.swift
//  photoCollection
//
//  Created by yousun on 2021/5/21.
//

import UIKit

private let reuseIdentifier = "showPhotoCollectionViewCell"

class showPhotoCollectionViewController: UICollectionViewController {
    
    // 從 showPhotoCollectionViewController 的 CollectionView 拉過來
    @IBOutlet var postCollectionView: UICollectionView!
    
    
    let postInfo :IgResponse.Graphql.User.Edge_owner_to_timeline_media
    
    let indexPath :Int
    
    let userImageUrl :URL
    
    let userName :String
    
    var isShow: Bool = false

    // 接收資料
    init?(coder: NSCoder ,userinfo:IgResponse ,indexPath:Int) {
        
        self.postInfo = userinfo.graphql.user.edge_owner_to_timeline_media
        self.indexPath = indexPath
        self.userImageUrl = userinfo.graphql.user.profile_pic_url
        self.userName = userinfo.graphql.user.username
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // 點選到目前的貼文頁面
    override func viewDidLayoutSubviews() {
        
        if isShow == false {
            postCollectionView.scrollToItem(at: IndexPath(item: self.indexPath, section: 0), at: .top, animated: true)
            isShow = true
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return postInfo.edges.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? showPhotoCollectionViewCell else{return UICollectionViewCell()}
    
        
        // 抓點選主頁的貼文圖片
        URLSession.shared.dataTask(with: postInfo.edges[indexPath.item].node.display_url) { (data, response, error) in
            
            if let data = data {
                DispatchQueue.main.async {
                    cell.showPhotoImageView.image = UIImage(data: data)
                }
            }
        }.resume()
        
        
        // 抓使用者的頭貼
        URLSession.shared.dataTask(with: userImageUrl) { (data, response, error) in
            if let data = data{
                DispatchQueue.main.async {
                    cell.profileImageView.image = UIImage(data: data)
                }
            }
        }.resume()
    
        
        // 貼文內容的其他資訊
        cell.profileNameLabel.text = userName
        
        let likeCount = postInfo.edges[indexPath.item].node.edge_liked_by.count
        cell.whoLikeLabel.text = "Liked by Ken and \(likeCount) others"
                
        cell.showTextView.text = postInfo.edges[indexPath.item].node.edge_media_to_caption.edges[0].node.text
        
        
        let commentCount = postInfo.edges[indexPath.item].node.edge_media_to_comment.count
        cell.commentCountLabel.text = "View all \(commentCount) comments"
        
        cell.dateLabel.text = dateFormate(date: postInfo.edges[indexPath.item].node.taken_at_timestamp)
        
        cell.likeButton.setImage(UIImage(named: "iconLove"), for: UIControl.State.normal)
        
        return cell
    }

    
    // 時間轉換
    func dateFormate(date :Date) ->String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        let dateString = dateFormatter.string(from: date)
        
        return dateString
        
    }
    
    
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
