//
//  ViewController.swift
//  ch11Navigation
//
//  Created by 김규리 on 2022/01/20.
//

import UIKit

class ViewController: UIViewController, EditDelegate {
    
    let imgOn = UIImage(named: "lamp-on.png")
    let imgOff = UIImage(named: "lamp-off.png")
    
    var isOn = true
    var isZoom = false
    var orgZoom = false

    @IBOutlet var txMessage: UITextField!
    @IBOutlet var imgView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgView.image = imgOn
    }
    
    // prepare : 해당 세그웨이가 해당 뷰컨트롤러로 전환되기 직전에 호출되는 함수, 데이터 전달을 위해 사용
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editViewController = segue.destination as! EditViewController
        
        if segue.identifier == "editButton" {
            // 버튼을 클릭한 경우
            editViewController.textWayValue = "segue : use button"
        } else if segue.identifier == "editBarButton" {
            // 바 버튼을 클릭한 경우
            editViewController.textWayValue = "segue : use Bar button"
        }
        
        editViewController.textMessage = txMessage.text! // 메인의 텍스트메시지를 수정화면의 textMessage에 저장
        editViewController.isOn = isOn
        editViewController.isZoom = orgZoom
        editViewController.delegate = self // ????
    }
    
    // 수정화면의 데이터를 메인화면으로 전달
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        txMessage.text = message // message를 메인의 필드에 띄움
    }
    
    // 수정화면의 스위치 값을 메인화면으로 전달
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool) {
        if isOn {
            imgView.image = imgOn
            self.isOn = true // 메인화면의 전구 상태를 수정화면의 스위치 값으로 다시 전달
        } else {
            imgView.image = imgOff
            self.isOn = false
        }
    }
    
    // 수정화면의 확대 여부를 메인 화면으로 전달
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool) {
        let scale: CGFloat = 2.0 // 2배로 확대
        var newWidth: CGFloat, newHeight: CGFloat
        
        if isZoom { // true 상태라면
            if orgZoom {
                
            } else {
                self.isZoom = false
                self.orgZoom = true
                newWidth = imgView.frame.width*scale
                newHeight = imgView.frame.height*scale
                imgView.frame.size = CGSize(width: newWidth, height: newHeight) // 이미지 크기 변경
            }
            
        }
        else { // false 축소 상태
            if orgZoom {
                self.isZoom = true
                self.orgZoom = false
                newWidth = imgView.frame.width/scale
                newHeight = imgView.frame.height/scale
                imgView.frame.size = CGSize(width: newWidth, height: newHeight) // 이미지 크기 변경
            } else {
                
            }

        }
    }
    
}

