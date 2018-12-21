//
//  ViewController.swift
//  AlamofireTutorial
//
//  Created by Sreng Khorn on 14/12/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import UIKit
import Kingfisher
import FontAwesome_swift
import Alamofire

class ViewController: UIViewController, UpdateDelegation {

    func didUpdatePost() {
        print("delegate run....")
    }
    
    @IBOutlet weak var tableView: UITableView!
    let customCellId = "customCellId"
    private let refreshControl = UIRefreshControl()
    // MARK:
    let postLimit = 15
    
    // MARK: API Enpoints
    let baseUrl = "http://api-ams.me/v1/api/"
    var requestUrl: String {
        get {
            return baseUrl + "articles?page=1&limit=15"
        }
    }

    var post = PostDAO()
    var posts = [Post]()
    var postData: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Data ...")
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        
        fetchData()
        
        tableView.register(UINib.init(nibName: "PostStyleCell", bundle: nil), forCellReuseIdentifier: customCellId)
    }
 
    @objc func fetchData() {
        post.fetchData(resquestUrl: requestUrl) { post in
            self.posts = post
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: customCellId, for: indexPath) as! PostStyleCell
        let post = posts[indexPath.row]
        let imgUrl = post.imageUrl ?? "http://api-ams.me:80/image-thumbnails/thumbnail-17a62de1-cae9-4c8d-9421-a03c3ce281bb.jpg"
        if let url = URL(string: imgUrl) {
            let resource = ImageResource(downloadURL: url)
            cell.imageVIew.kf.setImage(with: resource, options: [.transition(.fade(0.2))])
        }
        
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.titleLabel.text = post.title
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
        DetailViewController.post = posts[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let post = posts[indexPath.row]
            let url = "\(baseUrl)articles/\(post.id!)"
            let header = [
                "Authorization" : "Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ="
            ]
            print("URL===>", url)
            Alamofire.request(url, method: .delete, headers: header).responseJSON { (response) in
                guard response.result.error == nil else {
                    print("error calling DELETE")
                    if let error = response.result.error {
                        print("Error: \(error)")
                    }
                    return
                }
                self.posts.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let modifyAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            AddEditViewController().delegate = self
            self.performSegue(withIdentifier: "editFormSegue", sender: self)
            AddEditViewController.post = self.posts[indexPath.row]
        })
        let cssCode: String = "fa fa-address-book"
        modifyAction.image = UIImage.fontAwesomeIcon(code: cssCode, style: .solid, textColor: .white, size: CGSize(width: 50, height: 50))
//        modifyAction.image = UIImage.fontAwesomeIcon(name: .addressBook, style: .brands, textColor: .white, size: CGSize(width: 50, height: 50))
//        modifyAction.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == posts.count - 1 {
            print("Loading more....")
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height {
            print("Loading more 2nd .. style ")
        }
    }
}
