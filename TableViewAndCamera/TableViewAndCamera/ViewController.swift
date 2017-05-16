//
//  ViewController.swift
//  TableViewAndCamera
//
//  Created by Cid Hsieh on 2017/5/16.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var dataArray = [String]()
    
    @IBOutlet weak var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myTableView.reloadData()
        
    }
    //按下+開啟相機
    @IBAction func cameraButton(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //拍完照確認照片後，跳轉至DetailViewController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let pushViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        if let selectedimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            pushViewController.newImage = selectedimage
        }
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.pushViewController(pushViewController, animated: true)

    }
    
    
    
}
extension ViewController: UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        return cell
    }
}


