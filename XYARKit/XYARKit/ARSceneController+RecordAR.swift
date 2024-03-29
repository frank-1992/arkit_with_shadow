//
//  ARSceneController+RecordAR.swift
//  XYARKit
//
//  Created by user on 4/8/22.
//

import UIKit
import ARKit
import SceneKit
import SCNRecorder
import Photos
import AVKit

public extension ARSceneController {
    func setupARRecord() {
        sceneView.prepareForRecording()
    }
    
    @objc
    func recordingAction(_ sender: UIButton) {
        if sender.tag == 100 {
            do {
                let _ = try sceneView.startVideoRecording()
            } catch {
                
            }
            sender.setTitle("Stop", for: .normal)
            sender.tag = 200
        } else {
            sceneView.finishVideoRecording { (videoRecording) in
                
                DispatchQueue.global().async {
                    let filePath = videoRecording.url.path
                    let videoCompatible = UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(filePath)
                    if videoCompatible {
                        UISaveVideoAtPathToSavedPhotosAlbum(filePath, self, #selector(self.didFinishSavingVideo(videoPath:error:contextInfo:)), nil)
                    } else {
                        print("failed")
                    }
                }
                
                /* Process the captured video. Main thread. */
                let controller = AVPlayerViewController()
                controller.player = AVPlayer(url: videoRecording.url)
                controller.modalPresentationStyle = .overFullScreen
                self.present(controller, animated: true)
            }
            sender.setTitle("Start", for: .normal)
            sender.tag = 100
        }
    }
    
    @objc
    func didFinishSavingVideo(videoPath: String, error: NSError?, contextInfo: UnsafeMutableRawPointer?) {
        if error != nil{
            print("failed")
        }else{
            print(videoPath)
            print("success")
        }
    }
}

extension ARSceneController: CameraButtonViewDelegate {
    func startCaptureVideo() {
        do {
            let videoRecording = try sceneView.startVideoRecording()
            videoRecording.$duration.observe(on: .main) { [weak self] duration in
                print(duration)
                if duration >= 60 {
                    self?.stopCaptureVideo()
                }
            }
        } catch {
        }
    }
    
    func stopCaptureVideo() {
        sceneView.finishVideoRecording { [weak self] videoRecording in
            let playerItem = AVPlayerItem(url: videoRecording.url)
            let controller = ARResultController(mediaType: .video(playerItem))
            controller.modalPresentationStyle = .overFullScreen
            self?.present(controller, animated: true)
        }
    }
}

