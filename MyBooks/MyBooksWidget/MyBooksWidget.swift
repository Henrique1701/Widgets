//
//  MyBooksWidget.swift
//  MyBooksWidget
//
//  Created by José Henrique Fernandes Silva on 19/08/21.
//

import WidgetKit
import SwiftUI

// MARK: TimelineProvider
struct ImageProvider: TimelineProvider {
    func placeholder(in context: Context) -> ImageEntry {
        ImageEntry(date: Date(), imageName: "dom_casmurro")
    }

    func getSnapshot(in context: Context, completion: @escaping (ImageEntry) -> ()) {
        let entry = ImageEntry(date: Date(), imageName: "dom_casmurro")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ImageEntry>) -> ()) {
        var entries: [ImageEntry] = []

        let entry = ImageEntry(date: Date(), imageName: "dom_casmurro")
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

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

// MARK: TimelineEntry
struct ImageEntry: TimelineEntry {
    let date: Date
    let imageName: String
}

struct InformationEntry: TimelineEntry {
    let date: Date
    let title: String
    let author: String
}

// MARK: View
struct ImageWidgetEntryView : View {
    var entry: ImageProvider.Entry
    
    var body: some View {
        ZStack (alignment: .topTrailing) {
            Image("dom_casmurro")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .shadow(color: .secondary, radius: 8)
                .padding()
            Image(systemName: "bookmark.fill")
                .foregroundColor(.blue)
                .padding()
        }
    }
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

// MARK: Widget
struct ImageWidget: Widget {
    let kind: String = "ImageWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ImageProvider()) { entry in
            ImageWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Cover Widget")
        .description("This is a widget that shows the cover of the last book you read.")
        .supportedFamilies([.systemSmall])
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

// MARK: WidgetBunble
@main
struct WidgetContainer: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        ImageWidget()
        InformationWidget()
    }
}

struct MyBooksWidget_Previews: PreviewProvider {
    static var previews: some View {
        ImageWidgetEntryView(entry: ImageEntry(date: Date(), imageName: "dom_casmurro"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        
        InformationWidgetEntryView(entry: InformationEntry(date: Date(), title: "Dom Casmurro", author: "Machado de Assis"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
