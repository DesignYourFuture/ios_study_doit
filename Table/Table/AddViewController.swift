//
//  AddViewController.swift
//  Table
//
//  Created by Hamlit Jason on 2021/02/25.
//

import UIKit


let MAX_ARRAY_NUM = 3
let PICKER_VIEW_COMUMN = 1
let PICKER_VIEW_HEIGHT:CGFloat = 40
var imageArray = [UIImage?]()
var imageFileName = [ "cart.png", "clock.png", "pencil.png" ]
var fileName = ""

class AddViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName.count
    }
    /*
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return itemsImageFile[row]
    }
     */
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: imageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        
        return imageView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        imgView.image = imageArray[row]
        fileName = imageFileName[row]

    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(80)
    }
    	
    @IBOutlet var tfAddItem: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0 ..< MAX_ARRAY_NUM {
            let image = UIImage(named: imageFileName[i])
            imageArray.append(image!)
        }
        imgView.image = imageArray[0]
        fileName = imageFileName[0]
    }
    
    @IBAction func btnAddItem(_ sender: UIButton) {
        items.append(tfAddItem.text!)
        itemsImageFile.append(fileName)
        tfAddItem.text="" // 텍스트필드의 내용을 지운다.
        _ = navigationController?.popViewController(animated: true) // 내비게이션의 루트뷰로 돌아간다.
        // 근데 여기 이것만으로는 이전뷰가 업데이트가 안되서 뷰윌어피어를 테이블 뷰 컨트롤러에 추가한다.
    }
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var imgPicker: UIPickerView!
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
