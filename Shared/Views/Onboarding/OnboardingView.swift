//
//  OnboardingView.swift
//  Zeitgeist
//
//  Created by Daniel Eden on 05/06/2021.
//

import SwiftUI

struct OnboardingView: View {
	@State var signInModel = SignInViewModel()
	
	var body: some View {
		GeometryReader { geometry in
			ScrollView {
				VStack(spacing: 12) {
					Spacer()

					ZeitgeistLogo()
						.padding(.vertical)
					
					Text("Welcome to Zeitgeist")
						.font(.largeTitle.bold())
					Text("Zeitgeist lets you see and manage your Vercel deployments.")
					Text("Watch builds complete, cancel or delete them, and get quick access to their URLs, logs, and commits.")
						.padding(.bottom)
					
					Button(action: { signInModel.signIn() }) {
						HStack {
							Spacer()
							Label("Sign In With Vercel", systemImage: "triangle.fill")
							Spacer()
						}
						.font(.body.bold())
						.padding()
						.padding(.horizontal)
					}.buttonStyle(.borderedProminent)
					
					Text("To get started, sign in with your Vercel account.")
						.font(.caption)
						.foregroundColor(.secondary)
					
					Spacer()
					
					HStack {
						Link(destination: URL(string: "https://zeitgeist.daneden.me/privacy")!) {
							HStack {
								Spacer()
								Text("Privacy Policy")
								Spacer()
							}
						}
						
						Link(destination: URL(string: "https://zeitgeist.daneden.me/terms")!) {
							HStack {
								Spacer()
								Text("Terms of Use")
								Spacer()
							}
						}
					}
					.buttonStyle(.bordered)
				}
				.padding()
				.frame(minHeight: geometry.size.height)
			}
			.background {
				ZStack(alignment: .top) {
					Color.clear.background(.regularMaterial).mask {
						LinearGradient(colors: [.black, .clear], startPoint: .top, endPoint: .bottom)
					}
					
					StatusBannerView()
						.redacted(reason: .placeholder)
				}
				.ignoresSafeArea()
			}
		}
	}
}

struct OnboardingView_Previews: PreviewProvider {
	static var previews: some View {
		OnboardingView()
	}
}