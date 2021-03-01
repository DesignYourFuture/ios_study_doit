//
//  ViewController.swift
//  CameraPhotoLibrary
//
//  Created by Hamlit Jason on 2021/02/27.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var imgView: UIImageView!
    
    var imagePicker : UIImagePickerController! = UIImagePickerController()
    var captureImage : UIImage!
    var videoURL : URL!
    var flagImageSave = false
    
    @IBOutlet var imgView2: UIImageView!
    @IBOutlet var imgView3: UIImageView!
    var numImage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // 사진 촬영
    @IBAction func btnCaptureImageFromCamera(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {// 카메라의 사용 가능 여부 확인
            flagImageSave = true // 카메라 촬영 후 저장할 것이기 때문에 이미지 저장을 허용한다
            
            imagePicker.delegate = self // 이미지 피커의 델리게이트를 셀플 ㅗ설정
            imagePicker.sourceType = .camera // 이미지 피커의 소스 타입을 카메라로 설정한다.
            imagePicker.mediaTypes = [kUTTypeImage as String] // 미디어 타입은 이렇게 설정한다.
            imagePicker.allowsEditing = false // 편집은 허용하지 않습니다.
            
            present(imagePicker, animated: true, completion: nil) // 현재 뷰 컨트롤러를 이미지픽커로 교체한다. 즉, 부에 이미지 픽커가 보이게한다.
        } else {
            myAlert("Camera inaccessable", message: "Application cannot access the camera")
        }
        numImage += 1
        
    }
    
    // 사진 불러오기
    @IBAction func btnLoadImageFromLibrary(_ sender: UIButton) {
        
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
        
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Photo album inaccessable", message: "Application cannot access the photo album")
        }
        numImage += 1
    }
    
    // 비디오 촬영
    @IBAction func btnRecordVideoFromCamera(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
        
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Camera inaccessable", message: "Application cannot access camera")
        }
    }
    
    // 비디오 불러오기
    @IBAction func btnLoadVideoFromLibrary(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
        
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Photo album inaccessable", message: "Application cannot access the photo album")
        }
    }
    
    // 델리게이트 메서드 구현 - 기능에 따라 매끄럽게 작동하도록 하기 위한 코드, 사용자가 사진이나 비디오를 촬영하거나 포토 라이브러리에서 선택이 끝났을 떄 호출된다.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString // 미디어의 종류를 확인
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) { //미디어의 종류가 이미지일 경우에
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage // 사진을 가져와 캡쳐이미지에 저장
            
            if flagImageSave { // 이 조건도 만족하면 가져온 사진을 포토라이브러리에 저장한다.
                // 즉, 불러오기가 아닌 촬영을 했을때 이 코드가 참으로 설정된다.
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            NSLog("NUMIMAGE VALUE IS  : \(numImage)")
            if numImage == 1 {
                imgView.image = captureImage
            } else if numImage == 2{
                imgView2.image = captureImage
            } else if numImage == 3{
                imgView3.image = captureImage
            } else {
                NSLog("NUMIMAGE VALUE IS OVER : \(numImage)")
            }
        } else if mediaType.isEqual(to: kUTTypeMovie as NSString as String) { // 미디어의 종류가 비디오일 경우
            if flagImageSave { // 촬영한 비디오를 가져와 포토 라이브러리에 저장한다
                videoURL = (info[UIImagePickerController.InfoKey.mediaURL] as! URL)
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
            }
        }
        
        self.dismiss(animated: true, completion: nil) // 현재의 뷰 컨트롤러를 제거한다. 즉, 뷰에서 이미지 피커 화면을 ㅔㅈ거하여 초기뷰를 보여준다.
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 사용자가 사진이나 비디오를 찍지않고 취소하거나 선택하지 않고 취소를 하는 경우 호출되는 메소드로, 이 경우는 다시 처음 뷰의 상태로 돌아가게끔 한다.
        numImage -= 1
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func btnImageInit(_ sender: Any) {
        imgView.image = nil
        imgView2.image = nil
        imgView3.image = nil
        numImage = 0
    }
    func myAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated:true, completion: nil)
    }
}

