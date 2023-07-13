//
//  LodingView.swift
//  MOWTOLED
//
//  Created by bekbolsun on 2023-07-11.
//

import Foundation
import SwiftUI

struct LoadingView1: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<LoadingView1>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<LoadingView1>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
