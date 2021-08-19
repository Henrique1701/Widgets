//
//  MyWidgets.swift
//  MyWidgets
//
//  Created by José Henrique Fernandes Silva on 18/08/21.
//

import WidgetKit
import SwiftUI

// MARK: TimelineProvider
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct ProviderTest: TimelineProvider {
    /// Um tipo que avisa o WidgetKit quando atualizar a exibição de um widget.
    func placeholder(in context: Context) -> MyNameEntry {
        MyNameEntry(date: Date(), myName: "José")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (MyNameEntry) -> Void) {
        let entry = MyNameEntry(date: Date(), myName: "Fernandes")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<MyNameEntry>) -> Void) {
        var entries: [MyNameEntry] = []
        
        let currenteDate = Date()
        entries.append(MyNameEntry(date: currenteDate, myName: "Henrique"))
        for minutesOffset in 1..<6 {
            let entryDate = Calendar.current.date(byAdding: .second, value: minutesOffset * 3, to: currenteDate)
            let entry = MyNameEntry(date: entryDate!, myName: "Henrique", index: minutesOffset)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}


// MARK: TimelineEntry
struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct MyNameEntry: TimelineEntry {
    let date: Date
    let myName: String
    var index = 0
}

// MARK: View
struct MyWidgetsEntryView : View {
    /// Essa estrutura serve é a visualização do meu widget (MyWidgets)
    var entry: Provider.Entry

    var body: some View {
        HStack {
            ForEach (0..<3) { _ in
                ZStack (alignment: .topTrailing) {
                    Image("dom_casmurro")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    Image(systemName: "bookmark.fill")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .padding()
                }
            }
        }.frame(width: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct NameWidgetEntryView: View {
    var entry: ProviderTest.Entry
    
    var body: some View {
        VStack {
            ForEach (0..<1) { _ in
                HStack {
                    Spacer()
                    Image("dom_casmurro")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    Spacer()
                    VStack {
                        Spacer()
                        Text("Dom Casmurro")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text("Machado de Assis")
                            .font(.callout)
                            .fontWeight(.light)
                        
                        Spacer()
                        
                        ZStack (alignment: .leading) {
                            Rectangle()
                                .frame(width: 150, height: 12, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(5)
                                .foregroundColor(.gray)
                            
                            Rectangle()
                                .frame(width: 100, height: 12, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(5)
                                .foregroundColor(.black)
                        }
                        HStack {
                            Spacer()
                            Text("62%")
                                .font(.footnote)
                                .fontWeight(.light)
                            Spacer()
                            Spacer()
                            Spacer()
                            Text("146/208")
                                .font(.footnote)
                                .fontWeight(.light)
                            Spacer()
                        }
                        Spacer()
                    }
                    Spacer()
                }.padding()
            }
        }
    }
}

// MARK: Widget
struct MyWidgets: Widget {
    /// Essa estrutura é responsável por configurar o Widget
    let kind: String = "MyWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MyWidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct NameWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "NameWidget", provider: ProviderTest()) { entry in
            NameWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Meu nome")
        .description("Esse widget mostra o meu nome")
        .supportedFamilies([.systemMedium])
    }
}

// MARK: WidgetBunble
@main
struct MyWidgetsContainer: WidgetBundle {
    /// Essa estrutua é um conteiner que abriga todos os Widgets
    @WidgetBundleBuilder
    var body: some Widget {
        MyWidgets()
        NameWidget()
    }
}

// MARK: Preview
struct MyWidgets_Previews: PreviewProvider {
    static var previews: some View {
        MyWidgetsEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        
        NameWidgetEntryView(entry: MyNameEntry(date: Date(), myName: "Henrique"))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
