//
//  CustomExtensions.swift
//  SoftvisionTestApp
//
//  Created by Akshay Jain on 04/10/20.
//  Copyright © 2020 akshay. All rights reserved.
//

import UIKit
/// Image cache
let imageCache = NSCache<AnyObject, AnyObject>()
/// ImageView Extension
extension UIImageView {
  /**
   Loading image on imageView from either from url or cache
   - Parameters: Url string for image
   */
  func setImage(from urlString: String) {
    image = UIImage(named: "placeholder")
    if let url = NSURL(string: urlString) {
      if let imageFromCache = imageCache.object(forKey: url as AnyObject) {
        image = imageFromCache as? UIImage
        return
      }
      DispatchQueue.global(qos: .default).async {
        if let data = NSData(contentsOf: url as URL) {
          DispatchQueue.main.async {
            if let image = UIImage(data: data as Data) {
              self.image = image
              imageCache.setObject(image, forKey: url as AnyObject)
            }
          }
        }
      }
    }
  }
}
