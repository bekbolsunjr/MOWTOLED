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
        HStack {
            Image(systemName: "person")
                .font(.largeTitle)
                .foregroundColor(.blue)
            Text("Заголовок")
                .font(.headline)
                .foregroundColor(.black)
        }
    }
}
