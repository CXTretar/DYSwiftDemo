//
//  RoomNormalViewController.swift
//  DYSwift
//
//  Created by CXTretar on 2020/3/1.
//  Copyright © 2020 CXTretar. All rights reserved.
//

import UIKit
import AVFoundation

class RoomNormalViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private lazy var videoQueue: DispatchQueue = DispatchQueue.global()
    private lazy var audioQueue: DispatchQueue = DispatchQueue.global()
    
    private lazy var session: AVCaptureSession = AVCaptureSession()
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    
    private var videoInput: AVCaptureDeviceInput?
    private var videoOutput: AVCaptureVideoDataOutput?
    private var movieFileOutput: AVCaptureMovieFileOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideo()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        stopCapture()
    }
    
    
}

// MARK:- 点击事件处理
extension RoomNormalViewController {
    
    @IBAction func startCapture() {
        view.layer.insertSublayer(previewLayer, at: 0)
        session.startRunning()
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/DYSwift.mp4"
        movieFileOutput?.startRecording(to: URL(fileURLWithPath: path), recordingDelegate: self)
    }
    
    @IBAction func stopCapture() {
        session.stopRunning()
        previewLayer.removeFromSuperlayer()
        movieFileOutput?.stopRecording()
    }
    
    @IBAction func switchSence() {
        guard var position = videoInput?.device.position else {
            return
        }
        
        position = position == .front ? .back : .front
        
        let devices = AVCaptureDevice.devices(for: .video)
        guard let device = devices.filter({$0.position == position}).first else {
            return
        }
        
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else {
            return
        }
        session.beginConfiguration()
        
        session.removeInput(self.videoInput!)
        session.addInput(videoInput)
        session.commitConfiguration()
        
        self.videoInput = videoInput
    }
    
    
}

// MARK:- 设置音频和视频输入输出
extension RoomNormalViewController {
    private func setupVideo() {
        let devices = AVCaptureDevice.devices(for: .video)
        
        guard let device = devices.filter({$0.position == .front}).first else {
            return
        }
        
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else {
            return
        }
        self.videoInput = videoInput
        session.addInput(videoInput)
        
        let videoOutput = AVCaptureVideoDataOutput()
        
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        session.addOutput(videoOutput)
        
        previewLayer.frame = view.bounds
        previewLayer.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.3).cgColor
        
        self.videoOutput = videoOutput
        
        self.movieFileOutput = AVCaptureMovieFileOutput()
        session.addOutput(movieFileOutput!)
    }
    
    private func setupAudio() {
        guard let device = AVCaptureDevice.default(for: .audio) else {
            return
        }
        
        guard let audioInput = try? AVCaptureDeviceInput(device: device) else {
            return
        }
        
        session.addInput(audioInput)
        
        let audioOutput = AVCaptureAudioDataOutput()
        audioOutput.setSampleBufferDelegate(self, queue: audioQueue)
        
        session.addOutput(audioOutput)
    }
}

// MARK:- 视频和音频输出代理回调
extension RoomNormalViewController: AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        if connection == self.videoOutput?.connection(with: .video) {
            print("采集到视频画面")
        }else {
            print("采集到音频数据")
        }
        
    }
}
extension RoomNormalViewController: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        print("开始写入")
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("结束写入")
    }
}
