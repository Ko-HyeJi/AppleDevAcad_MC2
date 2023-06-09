//
//  CameraFilterView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/04.
//

import SwiftUI

struct CameraFilterView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var data: DataModel
    @EnvironmentObject var router: Router<Path>
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(Color.black)
                    .frame(height: 160)
                    .opacity(0.5)

                VStack {
                    ZStack {
                        Text("Turn Down Time")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .bold()
                        HStack {
                            Spacer()
                            Button {
                                router.popToRoot()
                            } label: {
                                Image("ExitButton")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(.trailing, 15)
                            }
                        }
                    }
                    .padding(.top, 50)
                    
                    Text(data.isTimeOver ? "밤정리 마무리 후 사진을 찍어보세요!" : "방정리 전 비포 사진을 찍어주세요!")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
            
            ZStack {
                Rectangle()
                    .foregroundColor(Color.black)
                    .frame(height: 160)
                    .opacity(0.5)
                
                ShutterButtonView()
                    .foregroundColor(.white)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ShutterButtonView: View {
    @EnvironmentObject var data: DataModel
    @EnvironmentObject var viewModel: CameraViewModel
    @EnvironmentObject var router: Router<Path>
    
    var body: some View {
        if (!data.isTimeOver) { // before
            Button {
                router.push(.C)
                viewModel.capturePhoto()
            } label: {
                Image(systemName: "button.programmable")
                    .resizable()
                    .frame(width: 75, height: 75)
            }

        } else { // after
            Button {
                router.push(.E)
                viewModel.capturePhoto()
            } label: {
                Image(systemName: "button.programmable")
                    .resizable()
                    .frame(width: 75, height: 75)
            }
        }
    }
}

//struct CameraFilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraFilterView()
//    }
//}
