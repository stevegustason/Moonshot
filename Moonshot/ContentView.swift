//
//  ContentView.swift
//  Moonshot
//
//  Created by Steven Gustason on 4/8/23.
//

import SwiftUI

struct CustomText: View {
    let text: String

    var body: some View {
        Text(text)
    }

    init(_ text: String) {
        print("Creating a new CustomText")
        self.text = text
    }
}

struct ContentView: View {
    // Variable to define our column layout for our LazyVGrid. We can use adaptive sizes so that our grid automatically adjusts how much information it's showing based on the screen size of the user's device.
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120)),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                // LazyHGrids and LazyVGrids allow us to show scrolling data with multiple rows or columns. First, you have to define a layout (see our layout variable above), then use that in your lazy grid.
                ScrollView {
                    LazyVGrid(columns: layout) {
                        ForEach(0..<1000) {
                            Text("Item \($0)")
                        }
                    }
                }
                
                // Here's an example of a LazyHGrid
                ScrollView(.horizontal) {
                    LazyHGrid(rows: layout) {
                        ForEach(0..<1000) {
                            Text("Item \($0)")
                        }
                    }
                }
                // JSON can encode and decode complex hierarchies of data. The key is to create separate types for each level you have. As long as the data matches the hierarchy you've asked for, Codable is capable of decoding everything with no extra work.
                Button("Decode JSON") {
                    // Variable for our data - a User struct with a name and an Address, which itself is a struct with a street and city.
                    let input = """
                    {
                        "name": "Taylor Swift",
                        "address": {
                            "street": "555, Taylor Swift Avenue",
                            "city": "Nashville"
                        }
                    }
                    """

                    // User struct
                    struct User: Codable {
                        let name: String
                        let address: Address
                    }

                    // Address struct
                    struct Address: Codable {
                        let street: String
                        let city: String
                    }
                    
                    // We can convert our data to JSON
                    let data = Data(input.utf8)
                    // Create an instance of the decoder
                    let decoder = JSONDecoder()
                    // Then try to decode it and print some of the data
                    if let user = try? decoder.decode(User.self, from: data) {
                        print(user.address.city)
                    }
                }
                
                // NavigationLink allows us to present users with a new view. It can be a fully custom view, or something as simple as text, like the below. NavigationViews are for showing details about a user's selection, like they're digging deeper. Sheets are for unrelated content, like settings or a compose window. NavigationViews are often used with lists, like so.
                List(0..<100) { row in
                        NavigationLink {
                            Text("Detail \(row)")
                        } label: {
                            Text("Row \(row)")
                        }
                    }
                    .navigationTitle("SwiftUI")
                // Geometry reader is a powerful view type that allows us to adjust the size of our image dynamiccaly
                GeometryReader { geo in
                    Image("Zelda")
                    // Resizable makes our content resize to the size if its container
                        .resizable()
                    // ScaledToFit resizes the image proportionally
                        .scaledToFit()
                    // Frame allows us to specify the size of our content, and in this case we can use geometry to specify a dynamic width (80% of the screen)
                        .frame(width: geo.size.width * 0.8)
                    // If we add a full size frame, it will center our content instead of having it aligned top-left
                        .frame(width: geo.size.width, height: geo.size.height)
                }
                
                // Scroll views allow us to scroll arbitrary data or views created by hand, unlike List or Form for scrolling data. Important: When you add views to a scrollview, they're created immediately. However, you can use LazyVStack and LazyHStack to load content on demand instead.
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(0..<100) {
                            CustomText("Item \($0)")
                                .font(.title)
                        }
                    }
                    
                    // We can also make horizontal scrolling views, but then we need to make sure to use HStacks or LazyHStacks to make sure our content is laid out properly
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 10) {
                            ForEach(0..<100) {
                                CustomText("Item \($0)")
                                    .font(.title)
                            }
                        }
                    }
                    /*
                     // This makes our whole scroll view scrollable - without this, you have to click in the center to scroll your content. LazyVStacks always take up all space available howevere, so we don't need this.
                     .frame(maxWidth: .infinity)
                     */
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
