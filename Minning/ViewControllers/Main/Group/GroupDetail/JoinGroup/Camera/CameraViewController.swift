//
//  CameraViewController.swift
//  Minning
//
//  Created by 박지윤 on 2021/12/06.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import MobileCoreServices
import SharedAssets
import SnapKit

class CameraViewController: UIViewController {
    let camera = UIImagePickerController()
    let picImageView = UIImageView()
    
    let titleLabel: UILabel = {
        $0.text = "권장 인증방법"
        $0.font = .font20PBold
        $0.textColor = .white
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 2
        $0.layer.shadowOffset = CGSize(width: 0, height: 1)
        return $0
    }(UILabel())
    
    let subtitleLabel1: UILabel = {
        $0.text = "오전 5~8시 사이 명상 장소가 나오게"
        $0.font = .font16P
        $0.textColor = .white
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 2
        $0.layer.shadowOffset = CGSize(width: 0, height: 1)
        return $0
    }(UILabel())
    
    let subtitleLabel2: UILabel = {
        $0.text = "인증 사진을 찍어주세요"
        $0.font = .font16P
        $0.textColor = .white
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 2
        $0.layer.shadowOffset = CGSize(width: 0, height: 1)
        return $0
    }(UILabel())
    
    let dateLabel: UILabel = {
        $0.font = .font20PBold
        $0.textColor = .white
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 2
        $0.layer.shadowOffset = CGSize(width: 0, height: 1)
        return $0
    }(UILabel())
    
    let labelView = UIView()
    
    let photoView = UIView()
    
    let nowDate = Date()
    let dateFormatter = DateFormatter()
    var dateString: String = ""
    
    // MARK: - 세림님 뷰랑 연결해야 할 버튼
    let button = UIButton()
    
    let captureButton: UIButton = {
        $0.isUserInteractionEnabled = true
        $0.setImage(UIImage(sharedNamed: "camera_button"), for: .normal)
        return $0
    }(UIButton())

    override func viewDidLoad() {
        super.viewDidLoad()
        calcDate()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationItem.title = "인증 사진 찍기"
        navigationController?.navigationBar.barTintColor = .yellow
        
        view.addSubview(button)
        view.addSubview(picImageView)
        
        picImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(view.frame.width)
        }
        
        button.setTitle("카메라", for: .normal)
        button.addTarget(self, action: #selector(useCamera), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        
        button.snp.makeConstraints { make in
            make.top.equalTo(picImageView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
    
    func calcDate() {
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 EEEE a h시 mm분"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateString = dateFormatter.string(from: nowDate)
    }
}

extension CameraViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @objc func useCamera() {
        camera.sourceType = .camera
        
        // front: 전면, rear: 후면
        camera.cameraDevice = .rear
        camera.modalPresentationStyle = .fullScreen
        // custom
        camera.showsCameraControls = false
        camera.delegate = self
        present(camera, animated: true, completion: nil)
        
        camera.view.addSubview(captureButton)
        
        captureButton.addTarget(self, action: #selector(captureButtonPressed), for: .touchUpInside)
        
        captureButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-36)
            make.centerX.equalToSuperview()
        }
        
        // MARK: - 인증 문구
        camera.cameraOverlayView = photoView
        [titleLabel, subtitleLabel1, subtitleLabel2].forEach {
            labelView.addSubview($0)
        }
        
        labelView.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width)
            make.height.equalTo(view.frame.width)
        }
        
        camera.view.addSubview(labelView)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
        }
        
        subtitleLabel1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        subtitleLabel2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(20)
        }
        
        camera.view.addSubview(photoView)
        
        [dateLabel].forEach {
            photoView.addSubview($0)
        }
        
        dateLabel.text = dateString

        photoView.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width)
            make.height.equalTo(view.frame.width)
            make.centerY.equalToSuperview()
        }

        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(100)
        }

    }
    
    @objc func captureButtonPressed() {
        camera.cameraCaptureMode = .photo
        camera.takePicture()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? NSString {
            if mediaType.isEqual(to: kUTTypeImage as NSString as String ) {

                if let captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    let cropImage = cropToBounds(image: captureImage, width: Double(view.frame.width), height: Double(view.frame.width))
                    
                    let newImage = saveTextInImage(text: dateString, image: cropImage, atPoint: CGPoint(x: 100, y: 100))
                    
                    self.dismiss(animated: true)
                    navigationController?.pushViewController(PreviewViewController(image: newImage), animated: false)
                }
            }
        } else {
            print("Cannot find UIImagePickerController.InfoKey.mediaType in CameraViewController")
        }
    }
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
            let cgimage = image.cgImage!
        
            let contextImage: UIImage = UIImage(cgImage: cgimage)
            let contextSize: CGSize = contextImage.size
        
            var posX: CGFloat = 0.0
            var posY: CGFloat = 0.0
        
            var cgwidth: CGFloat = CGFloat(width)
            var cgheight: CGFloat = CGFloat(height)

            if contextSize.width > contextSize.height {
                posX = ((contextSize.width - contextSize.height) / 2)
                posY = 0
                cgwidth = contextSize.height
                cgheight = contextSize.height
            } else {
                posX = 0
                posY = ((contextSize.height - contextSize.width) / 2)
                cgwidth = contextSize.width
                cgheight = contextSize.width
            }

            let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)

            let imageRef: CGImage = cgimage.cropping(to: rect)!

            let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)

            return image
        }
    
    func saveTextInImage(text: String, image: UIImage, atPoint: CGPoint) -> UIImage {
        let textColor: UIColor = UIColor.white
        let textFont: UIFont = .font20PBold
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor
        ] as [NSAttributedString.Key: Any]
        
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        let rect = CGRect(origin: CGPoint(x: image.size.width / 6, y: image.size.height / 2), size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
