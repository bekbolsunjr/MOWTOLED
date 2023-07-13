//
//  CastomNavTitle.swift
//  MOWTOLED
//
//  Created by bekbolsun on 2023-07-11.
//

import Foundation
import SwiftUI

struct CustomNavigationTitle: View {
    var body: some View {
        VStack {
            Text("Москва — Санкт-Петербург")
                .font(
                  Font.custom("SF Pro Text", size: 15)
                    .weight(.semibold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
            
            Text("3 сентября, 1 чел")
              .font(Font.custom("SF Pro Text", size: 11))
              .kerning(0.07)
              .multilineTextAlignment(.center)
              .foregroundColor(Color(red: 0.35, green: 0.39, blue: 0.45))
        }
    }
}
