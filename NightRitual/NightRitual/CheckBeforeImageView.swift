import SwiftUI
import AVFoundation

struct CheckBeforeImageView: View {
    @EnvironmentObject var router: Router<Path>
    @EnvironmentObject var data: DataModel
    @EnvironmentObject var viewModel: CameraViewModel
    @State private var bottomSheetOn = false
    
    var body: some View {
        ZStack {
            Color(hex: "1C1C1E").edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
                    Rectangle().frame(height: 160).foregroundColor(.clear)
                    
                    HStack {
                        Spacer()
                        Button {
                            router.pop(to: .B)
                        } label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .frame(width: 13, height: 15)
                                .foregroundColor(.white)
                                .padding(.leading, 30)
                            Text("다시 찍기")
                            Spacer()
                        }
                    }
                    .padding(.top, 20)
                    .foregroundColor(.white)
                }
                
                Group {
                    Spacer()
                    
                    if let imageData = viewModel.recentImage?.pngData() {
                        let beforeImage = data.convertToUIImage(from: imageData)
                        Image(uiImage: beforeImage!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 390, height: 285)
                            .padding()
                    } else {
        //                Text("Did not take Before Image")
                    }
                    
                    Button {
                        bottomSheetOn = true
                    } label: {
                        Image("MusicIcon")
                            .resizable()
                            .frame(width: 54, height: 54)
                            .padding(.top)
                    }
                    ZStack {
                        Image("SpeechBubble")
                            .resizable()
                            .frame(width: 225, height: 56)
                        Text("밤정리를 도와줄 음악을 추가해보세요")
                            .foregroundColor(.white)
                            .font(.system(size: 13)).padding(.top)
                    }

                    Spacer()
                }
                
                ZStack {
                    Rectangle().frame(height: 160).foregroundColor(.clear)
                    
                    Button {
                        router.push(.D)
                        data.isTimerOn = true
                        UIApplication.shared.isIdleTimerDisabled = true
                        data.currentSec = 0
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 358, height: 56)
                                .foregroundColor(Color(hex: "5E5CE6"))
                                .padding()
                            Text("밤정리 시작하기")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .bold()
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $bottomSheetOn) {
            SelectMusicView(bottomSheetOn: $bottomSheetOn)
                .presentationDetents([.fraction(0.37), .fraction(0.371)])
                .foregroundColor(.white)
        }
    }
}
