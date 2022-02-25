//
//  EditViewController.swift
//  ch11Navigation
//
//  Created by 김규리 on 2022/01/20.
//

import UIKit

// 프로토콜 형태의 델리게이트 추가
// 뷰 컨트롤러 클래스 선언문 안에 상속 받기 -> 정의한 함수를 무조건 만들어야 함
protocol EditDelegate {
    func didMessageEditDone(_ controller: EditViewController, message: String)
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool)
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool)
}

class EditViewController: UIViewController {
    var textWayValue: String = "" // 레이블 텍스트 제어 변수
    var textMessage: String = "" // 메시지 변수
    
    var delegate : EditDelegate? // delegate 변수 생성
    var isOn = false // 수정화면에서 스위치 직접 제어 불가능
    var isZoom = false
    
    @IBOutlet var lblWay: UILabel!
    @IBOutlet var txMessage: UITextField! // 수정화면의 텍스트필드
    @IBOutlet var swIsOn: UISwitch!
    @IBOutlet var btnResize: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblWay.text = textWayValue
        txMessage.text = textMessage // 수정화면의 텍스트필드
        swIsOn.isOn = isOn // 스위치가 꺼져 있음
        
        if (isZoom) { // true 상태라면
            btnResize.setTitle("축소", for: .normal)
        }
        else { // false 축소 상태
            btnResize.setTitle("확대", for: .normal)
        }
    }

    // 메인화면으로 되돌아가는 함수
    @IBAction func btnDone(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didMessageEditDone(self, message: txMessage.text!) // delegate의 didMEssageEditDone 함수 호출 (message에 수정화면의 텍스트필드 내용 받음)
            delegate?.didImageOnOffDone(self, isOn: isOn) // 수정화면의 스위치 상태를 메인화면으로 전달
            delegate?.didImageZoomDone(self, isZoom: isZoom)
        }
        _ = navigationController?.popViewController(animated: true) // show 선택해서 들어오고 pop의 형태로 나가기
    }
    
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            isOn = true
        } else {
            isOn = false
        }
    }
    
    // 확대 버튼 클릭 시 동작하는 함수
    @IBAction func btnResizeImage(_ sender: UIButton) {
        if (isZoom) { // true 상태라면
            isZoom = false
            btnResize.setTitle("확대", for: .normal)
        }
        else { // false 축소 상태
            isZoom = true
            btnResize.setTitle("축소", for: .normal)
        }
        //isZoom = !isZoom // 확대,축소 여부 뒤집기
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
