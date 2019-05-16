//
//  MArticle.swift
//  NyTimes
//
//  Created by Maseeh Ahmed on 5/15/19.
//  Copyright © 2019 talat. All rights reserved.
//

import UIKit

class MArticle: NSObject {

    var articleTitle: String?
    var publishDate: String?
    var publishedBy: String?
    var articleUrl: String?
    var thumbnailUrl: String?
    
    
    init(articleTitle: String?,publishDate: String?,publishedBy: String?,articleUrl: String?,thumbnailUrl: String?){
        
        self.articleTitle = articleTitle
        self.publishDate = publishDate
        self.publishedBy = publishedBy
        self.articleUrl = articleUrl
        self.thumbnailUrl = thumbnailUrl
        
    }
    
}
