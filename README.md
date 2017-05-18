# TableViewAndCamera

＊開啟相機拍照功能參考

https://www.youtube.com/watch?v=v8r_wD_P3B8&t=398s


＊實現拍完照後就直接轉場至下一個畫面的程式碼(花費較多間的部分)

解決辦法：在imagePickerController的function裡寫進轉場的程式碼，跳轉至DetailViewController


      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
          let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
          let pushViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
          if let selectedimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
           
              //拿到DetailViewController的newImage屬性
              pushViewController.newImage = selectedimage
          }
          self.dismiss(animated: true, completion: nil)
          self.navigationController?.pushViewController(pushViewController, animated: true)

          //將DetailViewController的delegate設為自己
          pushViewController.delegate = self
      }


＊圖片與文字的儲存方式
1. 在回到上一頁的時候儲存照片
2. 用delegate方式將文字標籤傳回前一頁


       //回到前一頁要執行的動作，所以寫在viewWillDisappear
       override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            //回傳檔名
            delegate?.savedFileName(fileName: descriptionTextField.text!)

            //存擋的路徑
            let filePath = NSHomeDirectory() + "/Documents/" + "descriptionTextField.text".data"
            // 存擋的路徑轉成 URL
            let fileURL = URL(fileURLWithPath: filePath) 
            if let imageToSave = cameraImageView.image {
                // 先轉成 data
                let dataToSave = UIImageJPEGRepresentation(imageToSave, 1.0) 
                do{
                    try dataToSave?.write(to: fileURL) // 存檔到資料夾
                    print("is saved")
                    print(filePath)
                }catch{
                }
            }
        }




＊進入照片與文字的畫面後，照片可放大縮小
1. 在Storyboard設定ScrollView的Attributes的zoom max設定為3
2. controller服從：UIScrollViewDelegate protocol


       override func viewDidLoad() {
            super.viewDidLoad()       
            myScrollView.delegate = self

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
