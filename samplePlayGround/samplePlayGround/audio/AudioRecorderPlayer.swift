//
//  audio.swift
//  samplePlayGround
//
//  Created by 遠藤拓弥 on 19.6.2023.
//

import Foundation
import AVFoundation

class AudioRecorderPlayer: ObservableObject {
    private var audioEngine: AVAudioEngine!
    private var audioFormat: AVAudioFormat!
    private var audioBuffer: AVAudioPCMBuffer!
    private var audioFileURL: URL?

    init() {
        setupAudioSession()
        setupAudioEngine()
    }

    private func setupAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error.localizedDescription)")
        }
    }

    private func setupAudioEngine() {
        audioEngine = AVAudioEngine()

        let inputNode = audioEngine.inputNode

        let settings = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVSampleRateKey: 44100,
        ]

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
        let fileName = dateFormatter.string(from: Date()) + ".wav"
        guard let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        let fileURL = documentsPath.appendingPathComponent(fileName)
        audioFileURL = fileURL
        let audioFile = try! AVAudioFile(forWriting: fileURL, settings: AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: 44100, channels: 1, interleaved: true)!.settings)

        inputNode.installTap(onBus: 0, bufferSize: 1024, format: nil) { (buffer: AVAudioPCMBuffer, _: AVAudioTime) in
            // 音声を取得したら

              do {
                // audioFileにバッファを書き込む
                  try audioFile.write(from: buffer)
              } catch let error {
                print("audioFile.writeFromBuffer error:", error)
              }
          }


    }

    func startRecording() {
        do {
            audioEngine.prepare()
            try audioEngine.start()
        } catch {
            print("Failed to start recording: \(error.localizedDescription)")
        }
    }

    func stopRecording() {
        audioEngine.stop()
        audioEngine.reset()

    }



    func playbackRecording() {
        guard let fileURL = audioFileURL else {
            return
        }

        do {
            let audioFile = try AVAudioFile(forReading: fileURL)
            let audioPlayer = AVAudioPlayerNode()

            audioEngine.attach(audioPlayer)
            audioEngine.connect(audioPlayer, to: audioEngine.mainMixerNode, format: audioFile.processingFormat)

            audioPlayer.scheduleFile(audioFile, at: nil)
            audioEngine.prepare()

            try audioEngine.start()

            audioPlayer.play()
        } catch {
            print("Failed to playback recording: \(error.localizedDescription)")
        }
    }

    func stopPlayback() {
        audioEngine.stop()
        audioEngine.reset()
    }
}




