//
//  SignUpView.swift
//  Musico
//
//  Created by dgsw07 on 11/21/24.
//


import SwiftUI

struct SignUpView: View {
    @StateObject var signUpVM = SignUpViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var toGetNicknameView = false
    
    var body: some View {
            ZStack {
                VStack {
                    Spacer()
                    TextField("유저이름",text: $signUpVM.username)
                        .padding(.leading,43)
                    HStack {
                        if signUpVM.isSecure {
                            SecureField("비밀번호를 입력하세요", text: $signUpVM.password)
                                .foregroundColor(.black)
                                .tint(.indigo)
                        } else {
                            TextField("비밀번호를 입력하세요", text: $signUpVM.password)
                                .foregroundColor(.black)
                                .tint(.indigo)
                        }
                    }
                    .frame(width: 304, height: 46)
                    .background(.white)
                    .cornerRadius(8)
                    Spacer()
                    
                    Button("회원가입") {
                        Task {
                            let signupResult = await signUpVM.signup()
                            if signupResult {
                                toGetNicknameView = true
                            } else {
                                print("회원가입 실패")
                            }
                        }
                    }

                    .padding(.bottom, 60)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
#Preview {
    SignUpView()
}
