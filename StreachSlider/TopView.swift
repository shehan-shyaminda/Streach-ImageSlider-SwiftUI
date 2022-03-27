//
//  TopView.swift
//  crystalmartin
//
//  Created by Stephen Innovations on 2021-09-22.
//

import SwiftUI


struct TopView: View {
    var body : some View {
        HStack{
            VStack(alignment: .leading){
                HStack{
                    Image("bookmark")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                .padding(.top,15)
                Text("Streach Image Slider")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.leading,10)
            Spacer()
            Button(action: {}, label: {
                Image("Menu")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.primary)
            })
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 15 : UIApplication.shared.windows.first?.safeAreaInsets.top)
        .padding(.horizontal)
        .padding(.bottom)
        .background(BlurBG())
    }
}

struct BlurBG: UIViewRepresentable{
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
        return view
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {

    }
}
