//
//  ShareViewController.swift
//  TableViewAndCamera
//
//  Created by Cid Hsieh on 2017/5/17.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController, UIScrollViewDelegate {
    var dataArray = [String]()
    let filePath = NSHomeDirectory() + "/Documents/" + "FileNameArray.txt" // 找到存擋路徑

    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var myLabel: UILabel!
    var imageView:UIImageView?
    
    var indexNumber = 0
    var photoDescription = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myScrollView.delegate = self
        //讀取陣列
        if let loadedArray = NSArray(contentsOfFile: filePath) as? [String] {
            print(loadedArray)
            dataArray = loadedArray
        }
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100))
        imageView?.contentMode = .scaleAspectFit
        imageView?.clipsToBounds = true
        self.myScrollView.addSubview(imageView!)
        //讀取圖片
        let loadImage = UIImage(contentsOfFile: NSHomeDirectory() + "/Documents/" + "\(dataArray[indexNumber]).data")
        imageView?.image = loadImage
        myLabel.text = photoDescription
    }
    //讓圖片可以縮放
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    


}
