//
//  PostStyleCell.swift
//  AlamofireTutorial
//
//  Created by Sreng Khorn on 17/12/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import UIKit
import Kingfisher

class PostStyleCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageVIew: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageVIew.backgroundColor = .gray
        imageView!.kf.indicatorType = .activity
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UIImageView {
    var contentClippingRect: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }
        
        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = bounds.width / image.size.width
        } else {
            scale = bounds.height / image.size.height
        }
        
        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0
        
        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
}


