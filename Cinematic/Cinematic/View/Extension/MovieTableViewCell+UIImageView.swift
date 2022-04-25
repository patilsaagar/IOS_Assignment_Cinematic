//
//  UIImageView+LoadURLImage.swift
//  Cinematic
//
//  Created by sagar patil on 22/04/2022.
//

import UIKit

// Alternative to SDWebImage po fetch image from URL
extension UIImageView {
    func loadImageFrom(url: URL){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
