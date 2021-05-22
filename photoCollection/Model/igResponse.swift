//
//  igResponse.swift
//  photoCollection
//
//  Created by yousun on 2021/5/19.
//

import Foundation


struct IgResponse:Decodable {
    
    let graphql:Graphql
    
    struct Graphql:Decodable {
        
        let user:User
        
        struct User:Decodable {
            
            let full_name:String //名字
            
            let biography:String //自我介紹
            
            let external_url :URL? // 作者新增的網頁連結
            
            let edge_follow:Edge_follow
            
            struct Edge_follow:Decodable {
                let count:Int //追蹤人數
            }
            
            let edge_followed_by:Edge_followed_by
            
            struct Edge_followed_by:Decodable {
                let count:Int // 被追蹤人數
            }
            
            let profile_pic_url:URL // 使用者頭貼
            
            let username:String // 帳號
            
            let edge_owner_to_timeline_media:Edge_owner_to_timeline_media
            
            struct Edge_owner_to_timeline_media:Decodable {
                
                let count:Int // 總貼文數
                
                let edges:[Edges]
                
                struct Edges:Decodable {
                    let node:Node
                
                    struct Node:Decodable{
                        let display_url:URL // 貼文圖片
                        let edge_media_to_caption:Edge_media_to_caption
                    
                        struct Edge_media_to_caption:Decodable {
                            let edges:[Edges]
                        
                            struct Edges:Decodable {
                                let node:Node
                            
                                struct Node:Decodable {
                                    let text:String // 貼圖文字
                                }
                            }
                        }
                        let edge_media_to_comment:Edge_media_to_comment
                        
                        struct Edge_media_to_comment:Decodable {
                            let count:Int // 留言數量
                        }
                        let edge_liked_by:Edge_liked_by
                        
                        struct Edge_liked_by:Decodable {
                            let count:Int // 貼文按讚數
                        }
                        let taken_at_timestamp: Date // 貼文時間
                    }
                }
            }
        }
    }
}

