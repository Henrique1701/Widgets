//
//  MyBooksWidget.swift
//  MyBooksWidget
//
//  Created by José Henrique Fernandes Silva on 19/08/21.
//

import WidgetKit
import SwiftUI

@main
struct WidgetContainer: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        ImageWidget()
        InformationWidget()
    }
}
