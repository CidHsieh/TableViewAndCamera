//
//  DetailViewController.swift
//  TableViewAndCamera
//
//  Created by Cid Hsieh on 2017/5/16.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

//設protocol將檔名回傳到ViewController
protocol DetailViewControllerDelegate {
    func savedFileName(fileName: String)
}

class DetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var cameraImageView: UIImageView!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var delegate:DetailViewControllerDelegate?
    
    //接收穿過來的Image
    var newImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        cameraImageView.image = newImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //回到前一頁要執行的動作        
        // 1. 回傳檔名
        delegate?.savedFileName(fileName: descriptionTextField.text!)
        
        // 2. 存圖片，要存的是 Data
        let filePath = NSHomeDirectory() + "/Documents/" + "\(descriptionTextField.text!).data" //存擋的路徑
        let fileURL = URL(fileURLWithPath: filePath) // 存擋的 URL
        if let imageToSave = cameraImageView.image {
            let dataToSave = UIImageJPEGRepresentation(imageToSave, 1.0) // 先轉成 data
            do{
                try dataToSave?.write(to: fileURL) // 存檔到資料夾
                print("is saved")
                print(filePath)
            }catch{
            }
        }
    }
    

    
    



}
