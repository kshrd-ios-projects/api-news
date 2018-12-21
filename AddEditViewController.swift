//
//  AddEditViewController.swift
//  AlamofireTutorial
//
//  Created by Sreng Khorn on 20/12/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire

protocol UpdateDelegation: AnyObject {
    func didUpdatePost()
}

class AddEditViewController: UIViewController {
    weak var delegate: UpdateDelegation?
    static var post: Post!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
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
            titleTextField.text = p.title
            descriptionTextView.text = p.description
        }
    }
    
    @IBAction func updatePost(_ sender: Any) {
        let id = AddEditViewController.post.id
        let updateUrl = "http://api-ams.me/v1/api/articles/\(id!)"
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ="
        ]
        var parameters: Parameters = [:]
        if let p = AddEditViewController.post {
            let string = p.imageUrl ?? "http://placehold.jp/375x250.png"
            parameters["IMAGE"] = string
        }
        parameters["TITLE"] = titleTextField.text
        parameters["DESCRIPTION"] = descriptionTextView.text
    
        Alamofire.request("\(updateUrl)", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if (response.result.error != nil) {
                print(response.result)
            }
            self.navigationController?.popViewController(animated: true)
            self.delegate?.didUpdatePost()
        }
    }
    

}
