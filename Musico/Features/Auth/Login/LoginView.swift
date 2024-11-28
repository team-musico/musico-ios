//
//  LoginView.swift
//  Musico
//
//  Created by dgsw07 on 11/22/24.
//


import SwiftUI

struct LoginView: View {
    @ObservedObject var loginViewModel: LoginViewModel = .init()
    @Environment(\.dismiss) var dismiss
    @State private var isLoginSuccess = false
    @State private var showAlert = false
    @State var sideBarOn = false
    
    var body: some View {
            ZStack {
                VStack {
                    Spacer()
                    Image("logoImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120,height: 120)
                    
                    
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(lineWidth: 0.7)
                        .foregroundColor(.indigo)
                        .frame(width: 314,height: 48)
                        .overlay {
                            TextField("유저이름을 입력하세요",text: $loginViewModel.username)
                                .padding()
                        }
                        .padding(.bottom,10)
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(lineWidth: 0.7)
                        .foregroundColor(.indigo)
                        .frame(width: 314,height: 48)
                        .overlay {
                            TextField("비밀번호를 입력하세요",text: $loginViewModel.password)
                                .padding()
                        }
                    Spacer()
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("회원이 아니신가요?")
                    }
                    
                    Button("로그인") {
                        loginViewModel.login { success in
                            if success {
                                isLoginSuccess = true
                            } else {
                                print(loginViewModel.loginerrorMessage ?? "로그인 실패")
                                showAlert = true
                            }
                        }
                    }
                    .padding(.bottom, 60)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("로그인 실패"),
                            message: Text("다시 시도해 주세요."),
                            dismissButton: .default(Text("확인"))
                        )
                    }
                }
            }
        
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $isLoginSuccess) {
//            HomeView()
        }
    }
}

#Preview {
    LoginView()
}
