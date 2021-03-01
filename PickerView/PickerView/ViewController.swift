//
//  ViewController.swift
//  PickerView
//
//  Created by Hamlit Jason on 2021/02/21.
//

import UIKit

/*
 스토리보드에서 피커뷰를 뷰컨트롤러로 컨트롤+ 마우스로 델리게이트 연결이 중요하다.
 왜냐하면, 스토리 보드를 보면 우리가 원한 정보가 아닌데, 이걸 연결해주기 위함.
 */

class ViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    var imageArray = [UIImage?]()
    let PICKER_VIEW_HEIGHT:CGFloat = 80
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT // 피커 뷰 룰렛의 높이 재정의
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN /* 피커뷰에게 컴포넌트의 수를 정수 값으로 넘겨주는 델리게이트 메서드입니다. 즉, 피커뷰에 표시되는 열의 갯수를 의미한다.*/
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName.count /* 피커뷰에게 컴포넌트의 열의 갯수를 넘겨준다. 즉, 해당 열에서 선택할 수 있는 행의 갯수이다. */
    }
    /* 이 코드는 피커에 타이틀을 설정하는 메소드
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imageFileName[row] /* 피커뷰의 각 열의 타이틀을 문자열 값을 넘겨준다. 여기서는 이미지 파일네임에 저장되어 있는 파일 명을 넘겨준다.*/
    }*/
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lbImageFileName.text = imageFileName[row] // 선택된 거 세팅
        imageView.image = imageArray[row] // 선택된 거 세팅
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: imageArray[row])
        imageView.frame = CGRect(x:0, y:0, width: 100, height: 150)
        
        return imageView
    }

    let MAX_ARRAY_NUM = 10 // 이미지 파일명을 저장ㅎ할 배열의 최대크기
    let PICKER_VIEW_COLUMN = 1 // 피커 뷰의 열의 개수
    var imageFileName = [ "1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg", "9.jpg", "10.jpg", ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for i in 0 ..< MAX_ARRAY_NUM {
            let image = UIImage(named: imageFileName[i])
            imageArray.append(image)
        }
        lbImageFileName.text = imageFileName[0] // 처음 이미지 세팅
        imageView.image = imageArray[0] // 처음 이미지 세팅
    }

    @IBOutlet var lbImageFileName: UILabel!
    
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var imageView: UIImageView!
}

