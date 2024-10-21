//
//  UIImageView + Extension.swift
//  MVVMUIKit
//
//  Created by Vivek  Garg on 21/10/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let resource = KF.ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
