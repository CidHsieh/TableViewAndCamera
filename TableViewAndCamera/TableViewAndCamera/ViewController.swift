//
//  ViewController.swift
//  TableViewAndCamera
//
//  Created by Cid Hsieh on 2017/5/16.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, DetailViewControllerDelegate {
    
    var dataArray = [String]()
    let filePath = NSHomeDirectory() + "/Documents/" + "FileNameArray.txt" // 找到存擋路徑

    
    @IBOutlet weak var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        
        //讀取 Array
        if let loadedArray = NSArray(contentsOfFile: filePath) as? [String] {
            print(loadedArray)
            dataArray = loadedArray
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myTableView.reloadData()
        
    }
    
    //實作protocol，將檔名存入陣列中
    func savedFileName(fileName: String) {
        dataArray.append(fileName)
        print(dataArray)
        
        //存 Array
        let arrayToSave = NSArray(array: dataArray) //轉成 NSArray
        arrayToSave.write(toFile: filePath, atomically: true) // 存入資料夾
        print(filePath)
    }
    
    //按下+開啟相機
    @IBAction func cameraButton(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
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
        
        //將DetailViewController的delegate設為自己
        pushViewController.delegate = self

    }
    
}
extension ViewController: UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let pushViewController = storyboard.instantiateViewController(withIdentifier: "ShareViewController") as! ShareViewController
        pushViewController.indexNumber = indexPath.row
        pushViewController.photoDescription = dataArray[indexPath.row]
        self.navigationController?.pushViewController(pushViewController, animated: true)
        
    }
    
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.myLabel.text = dataArray[indexPath.row]
        //讀出圖片
        let filePath = NSHomeDirectory() + "/Documents/" + "\(dataArray[indexPath.row]).data"
        cell.myImageView.image = UIImage(contentsOfFile: filePath)
        
        return cell
    }
    
    //滑動刪除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            dataArray.remove(at: indexPath.row)
            myTableView.deleteRows(at: [indexPath], with: .left)
            
            let arrayToSave = NSArray(array: dataArray) //轉成 NSArray
            arrayToSave.write(toFile: filePath, atomically: true) // 存入資料夾
            
        }
        
    }
}


