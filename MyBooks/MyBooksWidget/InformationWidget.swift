//
//  InformationWidget.swift
//  MyBooksWidgetExtension
//
//  Created by José Henrique Fernandes Silva on 19/08/21.
//

import Foundation
import SwiftUI
import WidgetKit

struct InformationProvider: TimelineProvider {
    func placeholder(in context: Context) -> InformationEntry {
        let title = "Dom Casmurro"
        let author = "Machado de Assis"

        return InformationEntry(date: Date(), title: title, author: author)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (InformationEntry) -> Void) {
        let title = "Dom Casmurro"
        let author = "Machado de Assis"
        let entry = InformationEntry(date: Date(), title: title, author: author)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<InformationEntry>) -> Void) {
        var entries: [InformationEntry] = []
        
        let title = "Dom Casmurro"
        let author = "Machado de Assis"
        let entry = InformationEntry(date: Date(), title: title, author: author)
        entries.append(entry)
        
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct InformationEntry: TimelineEntry {
    let date: Date
    let title: String
    let author: String
}

struct InformationWidgetEntryView : View {
    var entry: InformationProvider.Entry
    
    var body: some View {
        VStack {
            Text("Dom Casmurro")
                .font(.title3)
                .fontWeight(.bold)
            Text("Machado de Assis")
                .font(.callout)
                .fontWeight(.light)
        }
    }
}

struct InformationWidget: Widget {
    let kind: String = "InformationWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: InformationProvider()) { entry in
            InformationWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Information Widget")
        .description("This is a widget that shows the information of the last book you read.")
        .supportedFamilies([.systemSmall])
    }
}

struct MyBooksWidget_Previews: PreviewProvider {
    static var previews: some View {
        InformationWidgetEntryView(entry: InformationEntry(date: Date(), title: "Dom Casmurro", author: "Machado de Assis"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
