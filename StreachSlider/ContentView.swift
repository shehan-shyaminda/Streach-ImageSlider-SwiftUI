//
//  ContentView.swift
//  StreachSlider
//
//  Created by STEPHEN INNOVATIONS on 2022-03-27.
//

import SwiftUI

struct ContentView: View {
    @State var imageArray: [String] = ["img1","img2","img3"]
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var currentIndex = 0
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State var show = false
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(.vertical, showsIndicators: false, content: {
                GeometryReader { geo in
                    VStack{
                        VStack{
                            TabView(selection: $currentIndex){
                                ForEach(0..<imageArray.count,id:\.self){ index in
                                    Image(imageArray[index])
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width, height: 250)
                                        .clipped()
                                }
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            .onReceive(timer, perform: { _ in
                                withAnimation(.spring()){
                                    currentIndex = currentIndex < imageArray.count ? currentIndex + 1 : 0
                                }
                            })
                                .frame(height: geo.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / 2.2 + geo.frame(in: .global).minY :  UIScreen.main.bounds.height / 2.2)
                                .offset(y: geo.frame(in: .global).minY > 0 ? -geo.frame(in: .global).minY : 0)
                                .onReceive(time, perform: { _ in
                                    
                                    let y = geo.frame(in: .global).minY
                                    
                                    if -y > (UIScreen.main.bounds.height / 4) - 50 {
                                        withAnimation{
                                            self.show = true
                                        }
                                    }
                                    else{
                                        withAnimation{
                                            self.show = false
                                        }
                                    }
                                    
                                })
                                .frame(height: UIScreen.main.bounds.height / 3.5)
                        }
                        VStack {
                            HStack {
                                Text("My Bridge")
                                Spacer()
                            }
                        }
                        .padding(.top, 15)
                    }
                }
            })
            if self.show{
                TopView()
            }
        }
        .statusBar(hidden: true)
        .edgesIgnoringSafeArea(.top)
    }
}
