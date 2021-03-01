//
//  ViewController.swift
//  Audio
//
//  Created by Hamlit Jason on 2021/02/26.
//

import UIKit
import AVFoundation
/*
 예제가 아닌 본문에서도 에러가 나는데, 해결하지 못했다.
 구글링으로 더 연습하기
 */
class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectAudioFile()
        if !isRecordMode { // 녹음모드가 아니면, 즉 재생모드이면
            initPlay() // 재생 모드 초기화
            btnRecord.isEnabled = false // 버튼 비활성화
            lblRecordTime.isEnabled = false // 레이블도 비활성화
        } else {
            initRecord()
        }
        
    }
    
    @IBOutlet var btnRecord : UIButton!
    @IBOutlet var lblRecordTime : UILabel!
   
    
    @IBAction func swRecordMode(_ sender : UISwitch) {
        /* 스위치 온 = 녹음 모드
         따라서 오디오 재생을 중지하고, 현재 재생 시간을 00:00으로 만들고
         녹음 모드를 트루로 만든다.
         녹음 버튼과 녹음 시간을 활성화한다.
         
         스위치 오프 = 재생 모드
         녹음 모드를 거짓으로 설정하고, 녹음 시간을 비활성화 한다.
         녹음 시간은 0 으로 초기화한다.
         
         오디오 파일을 선택하고, 모드에 따라 초기화할 함수를 호출한다.
         */
        if sender.isOn {
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            lblRecordTime!.text = convertNSTimeInterval2String(0)
            isRecordMode = true
            btnRecord.isEnabled = true
            lblRecordTime.isEnabled = true
        } else {
            isRecordMode = false
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
            lblRecordTime.text = convertNSTimeInterval2String(0)
        }
        selectAudioFile() // 모드에 따라 초기화할 함수 선택
        if !isRecordMode {
            initPlay()
        } else {
            initRecord()
        }
    }
    
    let timeRecordSelector:Selector = #selector(ViewController.updateRecordTime)
    
    @objc func updateRecordTime() {
        lblRecordTime.text = convertNSTimeInterval2String(audioRecorder.currentTime)
    }
    
    @IBAction func btnRecord(_ sender : UIButton) {
        if (sender as AnyObject).titleLabel?.text == "Record" {
            // 버튼 이름이 레코드이면 녹음을하고 스탑으로 변경
            audioRecorder.record()
            (sender as AnyObject).setTitle("Stop", for: UIControl.State())
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSelector, userInfo: nil, repeats: true) // 녹음할 때 타이머가 작동하도록 프로그레스타이머에 타이머스케줄트타이머 함수를 사용하는데, 간격은 0.1초로 생성합니다. 즉, 0.1초마다 셀렉터를 호출한다.
        } else {
            // 그렇지 않으면 녹음 멈추고 레코드로 변경하고 재생 버튼 활성화
            audioRecorder.stop()
            progressTimer.invalidate() // 녹음이 중지되면 타이머를 무효화합니다
            (sender as AnyObject).setTitle("Record", for: UIControl.State())
            btnPlay.isEnabled = true
            initPlay()
        }
    }
    
    var audioRecorder : AVAudioRecorder!
    var isRecordMode = false
    
    func selectAudioFile() {
        if !isRecordMode { // 녹음 모드가 아닐 떄, 즉 재생모드일떄
            audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        } else {
            let documentDirectoty = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documentDirectoty.appendingPathComponent("recordFile.m4a") // 녹음 모드일 때는 새 파일인 레코드파일.m4a가 생성된다.
        }
    }
    
    func initRecord() {
        // 녹음에 대한 설정
        /*
         포맷은 애플 로스리스이며
         음질은 최대
         비트율은 320000bps(320kbps)
         오디오 채널은 2
         샘플률을 44100Hz
         */
        let recordSettings = [
            AVFormatIDKey : NSNumber(value: kAudioFormatAppleLossless as UInt32),
            AVEncoderAudioQualityKey : AVAudioQuality.min.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey : 2,
            AVSampleRateKey : 44100.0] as [String : Any]
        do {
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        } catch let error as NSError {
            print("Error-initRecord : \(error)")
        }
        
        audioRecorder.delegate = self // 위에 오디오레코드델리게이트 선언해야한다.
        // 델리게이트 연결하고
        slVolume.value = 1.0 // 볼륨 슬라이더 값 1.0으로 설정
        audioPlayer.volume = slVolume.value // 오디오 플레이어의 볼륨도 슬라이더 값과 동일한 1.0으로 설정
        lblEndTime.text = convertNSTimeInterval2String(0) // 총 재생시간 0
        lblCurrentTime.text = convertNSTimeInterval2String(0) // 현재 재생시간 0
        setPlayButton(false, pause: false, stop: false) // 버튼 모두 비활성화
    
        let session = AVAudioSession.sharedInstance()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print(" Error-setCategory : \(error)")
        }
        
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print(" Error-setActive : \(error)")
        }
    }
    
    
    
    func initPlay(){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay : \(error)")
        }
        
        slVolume.maximumValue = MAX_VOLUME // 슬라이더의 최대볼륨을 상수 10.0으로 초기화한다
        slVolume.value = 1.0 // 슬라이더의 볼륨을 1.0으로 초기화한다.
        pvProgressPlay.progress = 0 // 프로그레스 뷰의 진행을 0으로 초기화합니다.
        
        audioPlayer.delegate = self // 오디오 플레이어 델리게이트를 셀프로한다.
        audioPlayer.prepareToPlay() // 프리페어 투 플레이 실행
        audioPlayer.volume = slVolume.value // 오디오 플레이어의 볼륨을 방금 앞에서 초기화한 슬라이더의 볼륨 값 1.0으로 초기화한다.
        
        lblEndTime.text = convertNSTimeInterval2String(audioPlayer.duration) // 오디오 파일의 재생 시간인 함수를 이용해 텍스트에 출력 이렇게 하는 이유는 오디오듀레이션의 반환값이 -- -- 형식의 실수라서 변환이 필요하다
        lblCurrentTime.text = convertNSTimeInterval2String(0) // 00:00이 출력되도록 0 넣기
        
        /*
        btnPlay.isEnabled = true
        btnPause.isEnabled = false
        btnStop.isEnabled = false
         */
        setPlayButton(true, pause: false, stop: false)
    }
    
    func setPlayButton(_ play:Bool, pause:Bool, stop:Bool) {
        // 버튼의 동작여부를 설정하는 부분
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    
    func convertNSTimeInterval2String(_ time:TimeInterval) -> String {
        let min = Int(time/60) // 재생 시간의 매개변수인 시간값을 60으로 나눈 몫을 정수 값으로 변환하여 초기화한다.
        let sec = Int(time.truncatingRemainder(dividingBy: 60)) // 시간값을 60으로 나눈 나머지 값을 정수 값으로 변환하여 상수 값에 초기화 합니다.
        let strTime = String(format: "%02d:%02d", min,sec) // 이 두 값을 활용해 다음과 같은 포맷으로 문자ㅕㅇㄹ을 변환하여 상수에 초기화한다.
        return strTime
    }

    @IBOutlet var pvProgressPlay: UIProgressView!
    @IBOutlet var lblCurrentTime : UILabel!
    @IBOutlet var lblEndTime : UILabel!
    
    @IBOutlet var btnPlay : UIButton!
    @IBOutlet var btnPause : UIButton!
    @IBOutlet var btnStop : UIButton!
    
    @IBOutlet var slVolume : UISlider!
    
    let timePlayerSelector:Selector = #selector(ViewController.updatePlayTime) // 재생 타이머를 위한 상수를 추가
    
    @objc func updatePlayTime() {
        lblCurrentTime.text = convertNSTimeInterval2String(audioPlayer.currentTime) // 재생 시간인 오디오플레이어 현재시간을 레이블에 나타납니다.
        pvProgressPlay.progress = Float(audioPlayer.currentTime/audioPlayer.duration) // 프로그레스 뷰에 진행상황에 오디오 플레이어의 현재시간을 오디오플레이어의 듀레이션으로 나눈 값으로 표시한다.
        //NSLog("curr"+String(audioPlayer.currentTime))
        //NSLog(String(audioPlayer.duration))
    }
    
    @IBAction func btnPlayAudio(_ sender: Any) {
        audioPlayer.play()
        setPlayButton(false, pause: true, stop: true)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true) //0.1초 간격으로 타이머를 생성하도록 구현하겠다. 셀렉터는 앞에서 선언한 상수를 사용한다.
    }
    
    @IBAction func btnPauseAudio(_ sender : UIButton) {
        audioPlayer.pause()
        setPlayButton(true, pause: false, stop: false)
    }
    
    @IBAction func btnStopAudio(_ sender : UIButton) {
        audioPlayer.stop()
        setPlayButton(true, pause: false, stop: false)
        audioPlayer.currentTime = 0 // 오디오 플레이어 안에 정의된 현재시간을 0 으로 설정
        lblCurrentTime.text = convertNSTimeInterval2String(0) // 텍스트 레이블에 보여지는게 0 으로
        progressTimer.invalidate() // 타이머를 무효화한다.
    }
    
    var audioPlayer : AVAudioPlayer!
    var audioFile : URL!
    var MAX_VOLUME : Float = 10.0
    var progressTimer : Timer!
    
    @IBAction func slChangeVolume(_ sender : UISlider) {
        // 슬라이더로 볼륨 조절
        audioPlayer.volume = slVolume.value
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // 오디오 플레이어가 끝나면 처음으로 돌아가게끔
        progressTimer.invalidate() // 타이머 무효화
        setPlayButton(true, pause: false, stop: false)
    }

}

