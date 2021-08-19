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

// MARK: TimelineEntry
struct ImageEntry: TimelineEntry {
    let date: Date
    let imageName: String
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

// MARK: WidgetBunble
@main
struct WidgetContainer: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        ImageWidget()
    }
}

struct MyBooksWidget_Previews: PreviewProvider {
    static var previews: some View {
        ImageWidgetEntryView(entry: ImageEntry(date: Date(), imageName: "dom_casmurro"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
