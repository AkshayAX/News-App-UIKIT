//
//  support.swift
//  page
//
//  Created by Akshaya Kumar N on 1/22/20.
//  Copyright © 2020 Akshaya Kumar N. All rights reserved.
//

import Foundation
import UIKit
import Firebase



 
    func corner(img:UIImageView)
    {
        
        img.layer.borderWidth = 1
        img.layer.cornerRadius =   img.frame.size.height/2
        img.clipsToBounds = true
        img.layer.shadowOpacity = 0.5
        img.layer.shadowRadius = 5
        
}


    func corners(img:UIView)
    {

        img.layer.borderWidth = 1
        img.layer.cornerRadius = 15
        img.clipsToBounds = true
        img.layer.shadowOpacity = 0.5
        img.layer.shadowRadius = 5
        
        
}

func roundbutt(imageButton:UIButton)
{
    imageButton.layer.cornerRadius = 0.5 * imageButton.bounds.size.width
    imageButton.layer.borderColor = UIColor.lightGray.cgColor
    imageButton.layer.borderWidth = 1.0
    imageButton.clipsToBounds = true
}







func alert(description:String,vc:UIViewController)
  {
      let alert = UIAlertController(title: "Error", message:description , preferredStyle: .alert)
      let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
      alert.addAction(ok)
    vc.present(alert, animated: true, completion: nil)
  }



extension UIImage {
    
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage?
    {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        
        let format = imageRendererFormat
        
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
 

