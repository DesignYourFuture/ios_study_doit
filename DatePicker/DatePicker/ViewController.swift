//
//  ViewController.swift
//  DatePicker
//
//  Created by Hamlit Jason on 2021/02/18.
//

import UIKit
// 기본 코드에 미션도 추가하였음.
class ViewController: UIViewController {

    let timeSelect : Selector = #selector(ViewController.updateTime) // 타이머가 구동되면 실행할 함수 지정
    let interval = 1.0 // 타이머의 간격 값
    var count = 0 // 타이머가 설정한 간격대로 실행하는지 확인하기 위한 값
    
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblPickerTime: UILabel!
    
    var alarmTime : String?
    var currentTime = ""
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender /*
         데이트 피커를 선택할 때 발생하는 액션 함수인 체인지데이트픽커가 호출되면서
         센더(자료형 : 유아이데이트픽커)라는 인수가 전달된다. 이는 센터를 데이트픽커 뷰라는 변수에 저장한다.
         */
        
        
        let formatter = DateFormatter() // 날짜를 출력하기 위하여 데이터포매터라는 클래스 상수 포매터를 선언함.
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE" // 포맷은 년 월 일 시 분 초 요일 순으로 설정한다.
        lblPickerTime.text = "SELECT:" + formatter.string(from: datePickerView.date)
        // 데이트 피커에서 선택한 날짜를 포매터의 데이트 포맷에서 설정한 포맷대로 스트링 메서드를 사용하여 문자열로 변환한다.
        // 데이터 포맷의 형식은 책 115쪽 또는 구글링 해보길 바람.

        formatter.dateFormat = "hh:mm aaa"
        alarmTime = formatter.string(from: datePickerView.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelect, userInfo: nil, repeats: true)
        //파라미터 : 타이머 간격, 동작될 뷰, 타이머가 구동될 때 실행할 함수, 사용자 정보, 반복 여부
    
    }
    var alarmcount = 0
    // 스위프트4에서는 #selector()를 인자로 사용될 메서도를 선언할 때 오브젝씨와 호환성을 위하여 함수 앞에 반드시 @objc를 붙여야 한다.
    @objc func updateTime() { // 여기 함수명에서 중요한건 위에 셀렉터에서 선언함 이름과 같아야 한다.!
        lblCurrentTime.text = String(count)
        count = count + 1
        
        let date = NSDate() // 현재시간을 함수 사용하여 가져온다
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblCurrentTime.text = "NOW: " + formatter.string(from: date as Date)
        
        formatter.dateFormat = "hh:mm aaa"
        currentTime = formatter.string(from: date as Date)
        
        
        if alarmTime == currentTime {
            if alarmcount == 0 {
                view.backgroundColor = UIColor.red
            
                let alarmAlert = UIAlertController(title: "알림", message: "설정된 시간입니다.", preferredStyle: .alert)
                let alarmAction = UIAlertAction(title: "네 알겠습니다.", style: UIAlertAction.Style.default, handler: nil)
                alarmcount = 1
            
                alarmAlert.addAction(alarmAction)
                present(alarmAlert, animated: true, completion: nil)
            }
        } else {
            view.backgroundColor = UIColor.white // 분이 달라지면 즉, 1분이 지나면 하얀색 화면으로
            alarmcount = 0
        }
    }


}


