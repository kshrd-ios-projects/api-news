//
//  AddEditViewController.swift
//  AlamofireTutorial
//
//  Created by Sreng Khorn on 20/12/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import UIKit
import Kingfisher

class AddEditViewController: UIViewController {
    static var post: Post!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPost()
    }
    
    func loadPost() {
        if let p = AddEditViewController.post {
            let string = p.imageUrl ?? "http://placehold.jp/375x250.png"
            let url = URL(string: string)
            let resource = ImageResource(downloadURL: url!)
            self.imageView.kf.setImage(with: resource, options: [.transition(.fade(0.2))])
//            postTitleLabel.text = p.title
//            descriptionTextView.text = p.description
        }
    }

}
