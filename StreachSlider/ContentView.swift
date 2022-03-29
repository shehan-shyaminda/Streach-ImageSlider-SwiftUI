//
//  ContentView.swift
//  StreachSlider
//
//  Created by STEPHEN INNOVATIONS on 2022-03-27.
//

import SwiftUI

struct ContentView: View {
    @State var imageArray: [String] = ["img1","img2","img3"]
    @State var stringArray: [String] = ["Tuutor Information","Overseas Accomodation","Flight Booking Information", "Student Visa"]
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var currentIndex = 0
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State var show = false
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(.vertical, showsIndicators: false, content: {
                GeometryReader { geo in
                    VStack{
                        TabView(selection: $currentIndex){
                            ForEach(0..<imageArray.count,id:\.self){ index in
                                Image(imageArray[index])
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                //                                        .frame(height: UIScreen.main.bounds.height / 3.5)
                                //                                        .clipped()
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                        .offset(y: geo.frame(in: .global).minY > 0 ? -geo.frame(in: .global).minY : 0)
                        .frame(height: geo.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / 3 + geo.frame(in: .global).minY :  UIScreen.main.bounds.height / 3)
                        .onReceive(time, perform: { _ in
                            
                            let y = geo.frame(in: .global).minY
                            
                            if -y > (UIScreen.main.bounds.height / 3) - 50 {
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
                        .onReceive(timer, perform: { _ in
                            withAnimation(.spring()){
                                currentIndex = currentIndex < imageArray.count ? currentIndex + 1 : 0
                            }
                        })
                    }
                }
                VStack {
                    VStack(spacing: 5) {
                        HStack{
                            Text("Bridge with us")
                                .font(.system(size: 30, weight: .semibold))
                            Spacer()
                        }
                        HStack{
                            Text("Improve skills & have a bright future")
                                .font(.system(size: 14))
                            Spacer()
                        }
                    }
                    .padding(.top, 15)
                    HStack{
                        Text("Categories")
                            .font(.system(size: 24, weight: .regular))
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(0..<10, id: \.self){ index in
                                Text("stringArray[\(index)]")
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.black, lineWidth: 2)
                                    )
                            }
                        }
                        .padding()
                    }
                }
                .padding(.top,  UIScreen.main.bounds.height / 3)
                .padding(.horizontal, 15)
                
            })
            if self.show{
                TopView()
            }
        }
        .statusBar(hidden: true)
        .edgesIgnoringSafeArea(.top)
    }
}
