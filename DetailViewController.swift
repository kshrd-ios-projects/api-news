//
//  DetailViewController.swift
//  AlamofireTutorial
//
//  Created by Sreng Khorn on 18/12/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class DetailViewController: UIViewController {
    static var post: Post!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPost()
    }
    
     fileprivate func loadPost() {
        if let p = DetailViewController.post {
            let string = p.imageUrl ?? "http://placehold.jp/375x250.png"
            let url = URL(string: string)
            let resource = ImageResource(downloadURL: url!)
            self.imageView.kf.setImage(with: resource, options: [.transition(.fade(0.2))])
            postTitleLabel.text = p.title
            descriptionLabel.text = p.description
        }
    }
}
