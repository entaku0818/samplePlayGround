//
//  AudioSwift.swift
//  samplePlayGround
//
//  Created by 遠藤拓弥 on 19.6.2023.
//

import SwiftUI

import SwiftUI

struct AudioRecorderPlayerApp: View {
    @StateObject private var recorderPlayer = AudioRecorderPlayer()

    var body: some View {
        VStack {
            Button(action: {
                recorderPlayer.startRecording()
            }) {
                Text("Start Recording")
            }
            Button(action: {
                recorderPlayer.stopRecording()
            }) {
                Text("Stop Recording")
            }
            Button(action: {
                recorderPlayer.playbackRecording()
            }) {
                Text("Playback Recording")
            }
            Button(action: {
                recorderPlayer.stopPlayback()
            }) {
                Text("Stop Playback")
            }
        }
    }
}

#Preview {
    AudioRecorderPlayerApp()
}
