//
//  DetailViewController.swift
//  TableViewAndCamera
//
//  Created by Cid Hsieh on 2017/5/16.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var cameraImageView: UIImageView!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    //接收穿過來的Image
    var newImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraImageView.image = newImage

    }
    
    @IBAction func cameraButton(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            cameraImageView.image = selectedimage
        }
        self.dismiss(animated: true, completion: nil)
    }
    



}
