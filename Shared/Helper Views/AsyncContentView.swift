//
//  AsyncContentView.swift
//  Verdant
//
//  Created by Daniel Eden on 29/05/2021.
//

import SwiftUI
import Combine

struct ErrorView: View {
  @ScaledMetric var spacing: CGFloat = 8
  var error: Error
  var retryHandler: (() async -> Void)?
  
  var body: some View {
    VStack(alignment: .leading, spacing: spacing) {
      Label(error.localizedDescription, systemImage: "exclamationmark.triangle.fill")
        .foregroundColor(.secondary)
      if let retryHandler = retryHandler {
        Button(action: { Task { await retryHandler() } }) {
          Label("Try Again", systemImage: "arrow.counterclockwise")
        }
      }
    }
  }
}

struct AsyncContentView<Source: LoadableObject, Content: View>: View {
  @AppStorage("refreshFrequency") var refreshFrequency: Double = 5.0
  @Environment(\.scenePhase) var scenePhase
  @ObservedObject var source: Source
  var placeholderData: Source.Output?
  var content: (Source.Output) -> Content
  var allowsRetries: Bool
  var autoLoad = true
  
  @State var isAnimating = false
  
  init(source: Source,
       autoLoad: Bool = true,
       placeholderData: Source.Output? = nil,
       allowsRetries: Bool = true,
       @ViewBuilder content: @escaping (Source.Output) -> Content) {
    self.source = source
    self.autoLoad = autoLoad
    self.placeholderData = placeholderData
    self.content = content
    self.allowsRetries = allowsRetries
  }
  
  var body: some View {
    Group {
      switch source.state {
      case .idle:
        Color.clear.onAppear {
          Task.init {
            if autoLoad {
              await source.load()
            }
          }
        }
      case .loading:
        if let placeholderData = placeholderData {
          content(placeholderData)
            .redacted(reason: .placeholder)
            .opacity(isAnimating ? 0.5 : 1)
            .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isAnimating)
            .onAppear { self.isAnimating = true }
        } else {
          ProgressView()
        }
      case .failed(let error):
        ErrorView(error: error, retryHandler: allowsRetries ? source.load : nil)
      case .loaded(let output):
        content(output)
      case .refreshing(let output):
        content(output)
      }
    }
    .task {
      if autoLoad {
        await source.load()
      }
    }
    .onChange(of: scenePhase) { newValue in
      switch newValue {
      case .active:
        Task { if autoLoad { await source.load() } }
        return
      default:
        return
      }
    }
  }
}