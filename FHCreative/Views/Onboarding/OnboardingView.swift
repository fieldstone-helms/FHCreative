//
//  OnboardingView.swift
//  FHCreative
//
//  Created by Admin on 09/10/2019.
//  Copyright © 2019 MontiRed. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    
    @State var currentPageIndex = 0
    
    var subView = [
        UIHostingController(rootView: OnboardingSubview(imageString: "OnboardingOne", titleString: "Create account and \n add profile")),
        UIHostingController(rootView: OnboardingSubview(imageString: "OnboardingTwo", titleString: "Add or browse \n jobs")),
        UIHostingController(rootView: OnboardingSubview(imageString: "OnboardingThree", titleString: "Get work done, \n get paid"))
    ]
    
    var caption = [
        "Explore sample demos tailored for artists, game designers, software developers, and integration engineers. ",
        "The same SDKs and documentation you’ve been using to develop for Rift will work with Rift S. Get started with our native PC SDK, Unreal or Unity integrations.",
        "Dive in with our step-by-step setup guides, sample scenes and tutorials for optimizing VR performance, haptics for Touch controllers, and more."
    ]
    
    var body: some View {
        
        ZStack {
            PageViewController(viewControllers: subView, currentPageIndex: $currentPageIndex)
                .edgesIgnoringSafeArea(.all)
            
            VStack() {
                HStack {
                    FHIconType(imageType: "light")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                        .padding(40)
                    
                    Spacer()
                }
                
                Spacer()
                
                Text(caption[currentPageIndex])
                    .font(.body)
                    .fontWeight(.light)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .frame(height: 200.0)
                    .padding()
                    .fixedSize(horizontal: false, vertical: true)
                
                HStack {
                    PageControl(numberOfPages: subView.count, currentPageIndex: $currentPageIndex)
                    
                    Spacer()
                    
                    Button(action: {
                        if self.currentPageIndex + 1 == self.subView.count {
                            self.currentPageIndex = 0
                        } else {
                            self.currentPageIndex += 1
                        }
                    }) {
                        ButtonContent()
                    }
                }
                .padding(40)
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

struct ButtonContent: View {
    var body: some View {
        Image(systemName: "arrow.right")
            .resizable()
            .foregroundColor(.white)
            .frame(width: 30, height: 30)
            .padding(10)
            .background(Color("FHBabyBlue"))
            .cornerRadius(30)
    }
}
