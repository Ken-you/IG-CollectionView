//
//  photoCollectionViewController.swift
//  photoCollection
//
//  Created by yousun on 2021/5/19.
//

import UIKit


private let reuseIdentifier = "imagesCollectionViewCell"

class photoCollectionViewController: UICollectionViewController {
    
    @IBOutlet var profileView: UIView!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var postsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var introTextView: UITextView!
    @IBOutlet weak var WebButton: UIButton!
    
    
    var igData :IgResponse?
    var igImagePost = [IgResponse.Graphql.User.Edge_owner_to_timeline_media.Edges] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchIGData()
        addprofileView()
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

    @IBSegueAction func showPhoto(_ coder: NSCoder) -> showPhotoCollectionViewController? {
        guard let row = collectionView.indexPathsForSelectedItems?.first?.row else { return nil }
        
        return showPhotoCollectionViewController.init(coder: coder, userinfo: igData!, indexPath: row)
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return igImagePost.count
    }

    
    // 主頁的底下貼文圖片
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! photoCollectionViewCell

        let item = igImagePost[indexPath.item]

        URLSession.shared.dataTask(with: item.node.display_url) { (data, respones, error) in

            if let data = data{
                DispatchQueue.main.async {

                    cell.igImageView.image = UIImage(data: data)

                }
            }

        }.resume()

        return cell
    }
    
    
    
    
    // 解析JSON檔
    func fetchIGData() {
        
        // 正常連接上 IG 後台網址
//        let urlStr = "https://www.instagram.com/neneko_ig/?__a=1"
        
        // 存放Json 在自己 Mac 當後台
        let urlStr = "http://127.0.0.1/neneko_ig.json"
        
        if let url = URL(string: urlStr){
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                let decoder = JSONDecoder()
                
                decoder.dateDecodingStrategy = .secondsSince1970
                
                if let data = data{
                    
                    do {
                        
                        let searchResponse = try decoder.decode(IgResponse.self, from: data)
                        
                        self.igData = searchResponse
                            
                        DispatchQueue.main.async {
                            
                            // JSON 檔內的貼文圖
                            self.igImagePost = (self.igData?.graphql.user.edge_owner_to_timeline_media.edges)!
                            
                            // 設定 View 裡面的元件
                            self.userNameLabel.text = searchResponse.graphql.user.full_name
                            self.postsLabel.text = "\(searchResponse.graphql.user.edge_owner_to_timeline_media.count)"
                            self.followersLabel.text = "\(searchResponse.graphql.user.edge_followed_by.count)"
                            self.followingLabel.text = "\(searchResponse.graphql.user.edge_follow.count)"
                            self.introTextView.text = searchResponse.graphql.user.biography
                            self.WebButton.setTitle(searchResponse.graphql.user.external_url, for: .normal)
                            
                            self.collectionView.reloadData()
                        }
                        
                    } catch  {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    
    
    // 設定 View
    func addprofileView() {
        
        // 要使用自己設定的 Auto Layout 這個值要設成 false
        profileView.translatesAutoresizingMaskIntoConstraints = false
        
        // 在collectionView 加入 View
        collectionView.addSubview(profileView)
        
        // 高設 413
        profileView.heightAnchor.constraint(equalToConstant: 413).isActive = true
        
        // 左右與 collectionView 無間距
        profileView.leadingAnchor.constraint(equalTo: collectionView.frameLayoutGuide.leadingAnchor).isActive = true
        profileView.trailingAnchor.constraint(equalTo: collectionView.frameLayoutGuide.trailingAnchor).isActive = true
        
        // 上與 contentLayoutGuide 無間距並設定 Priority 降為 999 以解決衝突
        let topConstraint = profileView.topAnchor.constraint(equalTo: collectionView.contentLayoutGuide.topAnchor)
        topConstraint.priority = UILayoutPriority(999)
        topConstraint.isActive = true
        
        // 設定 View 與 collectionView Top 間距 50，讓滑到上方仍然有 50 point 的間距
        profileView.bottomAnchor.constraint(greaterThanOrEqualTo: collectionView.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
    }
    
    
    
            
    
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


