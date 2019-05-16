//
//  MasterViewController.swift
//  NyTimes
//
//  Created by Maseeh Ahmed on 5/15/19.
//  Copyright © 2019 talat. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
//    var objects = [Any]()
    var articles = [MArticle]()
    @IBOutlet var tblArticles: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        ArticleRequest() { (result:Bool) -> (Void) in
            if(result){
              
                self.tblArticles.reloadData()
            }else{
                self.ShowAlert(message: AppStrings.kLoadingFailed)            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppStrings.kSegueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                let article = articles[indexPath.row]
                let controller = segue.destination as! DetailViewController
                
                controller.article = article
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ArticleCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ArticleCell  else {
            fatalError("The dequeued cell is not an instance of RecentTableViewCell.")
        }

        let article = articles[indexPath.row]
        cell.lblTitle.text = article.articleTitle
        cell.lblPublishedBy.text = article.publishedBy
        cell.lblPublishedDate.text = article.publishDate

        cell.imgThumbnail.downloadImageFrom(link: article.thumbnailUrl ?? "", contentMode: UIView.ContentMode.scaleAspectFit)
        cell.imgThumbnail.layer.cornerRadius = cell.imgThumbnail.frame.size.width / 2
        cell.imgThumbnail.clipsToBounds = true
        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        self.performSegue(withIdentifier: AppStrings.kSegueIdentifier, sender: self)
        tableView.deselectRow(at: indexPath, animated: false)
        }
    
    
    func ArticleRequest(withCompletionHandlerHomeData: @escaping (_ result:Bool)->(Void) ) {
        
       
            WebManager.GetArticleInfoFromApi() { (responseObject) -> (Void) in

                if responseObject != nil {
                    if let response = responseObject {
                        
                        let status = response["status"] as! String
                        if (status == "OK"){
                        
                            let results = response["results"] as! [AnyObject]
                            
                            for result in results {
                               
                                let thumbnail = self.GetThumbnail(media: result["media"] as! [AnyObject])
                                print("articles", result["title"] as! String)
                                let article = MArticle(articleTitle: result["title"] as? String ?? "", publishDate: result["published_date"] as? String ?? "", publishedBy: result["byline"] as? String ?? "", articleUrl: result["url"] as? String ?? "", thumbnailUrl: thumbnail)
                                
                                self.articles.append(article)
                                
                            }
                        withCompletionHandlerHomeData(true)
                    }
                        else{
                            print("failed 1");
                            withCompletionHandlerHomeData(false)
                        }
                    }
                    
                }
                
            }
    }
    

    func GetThumbnail(media: [AnyObject]) -> String {
        
        var thumbnail = ""
        
        for dataInfo in media{
            
            let type = dataInfo["type"] as! String
            
            if (type == "image") {
            
                let metadata = dataInfo["media-metadata"] as! [AnyObject];
                for dataInfo1 in metadata{
                    
                    
                    if (dataInfo1["format"] as! String == "Standard Thumbnail") {
                        thumbnail = dataInfo1["url"] as! String
                        
                        break;
                    }
                    
                }

                
            }
            
        }
        
        return thumbnail
    }
    
     func ShowAlert(message: String) {
        
        let alertController = UIAlertController(title: AppStrings.ApplicationName, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
    
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
}

extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask(with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}

