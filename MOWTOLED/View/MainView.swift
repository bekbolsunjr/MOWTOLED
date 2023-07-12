import Foundation
import SwiftUI


struct MainView: View {
    
    
    
    @State var results: [Result] = []
    @State var cheapestTiketID: String
    
    func loadResults() {
        APIManager.shared.getTiket { results in
            self.results = results.sorted { $0.price.value < $1.price.value }
            cheapestTiketID = self.results[0].id
        }
    }
    
    
    var body: some View {
        
        
        // MARK: Main View
        NavigationView {
            List(results, id: \.id) { result in
                NavigationLink(destination: DetailView(result: result)){
                    cell(result: result)
                }
                
                
                
            }.navigationTitle("Москва - Санкт-Питербукрг")
                .navigationBarTitleDisplayMode(.inline)
                .listRowBackground(Color.clear)
            //                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 110, trailing: 0))
                .listRowSeparator(.hidden)
                .onAppear{
                    loadResults()
                }
            
        }
        
    }
    
    
    
    
    
    func cell(result: Result) -> some View {
        
        VStack(alignment: .leading){
            HStack { // самый дешовый
                if cheapestTiketID == result.id {
                    Text("Самый дешёвый")
                        .font(
                            Font.custom("SF Pro Text", size: 13)
                                .weight(.semibold))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 0)
                        .frame(height: 20, alignment: .leading)
                        .background(Color(red: 0.21, green: 0.78, blue: 0.41))
                        .cornerRadius(100)
                }
            }
            
            
            
            HStack { // цена, лого
                Text("\(result.price.value) ₽")
                    .font(
                        Font.custom("SF Pro Text", size: 19)
                            .weight(.semibold)
                    )
                    .foregroundColor(Color(red: 0.05, green: 0.45, blue: 1))
                    .frame(maxWidth: .infinity, minHeight: 23, maxHeight: 23, alignment: .topLeading)
                
                HStack(alignment: .center, spacing: 0) {
                    if result.airline == "Аэрофлот" {
                        Image("AeroflotOnDarkFalse")
                    }
                    if result.airline == "Победа" {
                        Image("PobedaOnDarkFalse")
                    }
                    if result.airline == "Smartavia" {
                        Image("SmartAvOnDarkFalse")
                    }
                    if result.airline == "S7" {
                        Image("S7OnDarkFalse")
                    }
                    
                }
                .padding(.bottom, 10)
                .frame(width: 26, height: 26, alignment: .trailing)
                
            }
            
            HStack { // осталось
                
                if result.availableTicketsCount <= 10 {
                    Text("Осталось \(result.availableTicketsCount) билетов по этой цене")
                        .font(Font.custom("SF Pro Text", size: 13))
                        .foregroundColor(Color(red: 0.87, green: 0.26, blue: 0.31))
                        .frame(maxWidth: .infinity, minHeight: 16, maxHeight: 16, alignment: .topLeading)
                }
            }
            
            HStack { // От куда? , время
                Text("Москва")
                    .font(
                        Font.custom("SF Pro Text", size: 15)
                            .weight(.semibold)
                    )
                    .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
                    .frame(maxWidth: .infinity, minHeight: 18, maxHeight: 18, alignment: .topLeading)
                
                Text(formatTime("\(result.arrivalDateTime)")) //Время вылета
                    .font(
                        Font.custom("SF Pro Text", size: 15)
                            .weight(.semibold)
                    )
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
                    .frame(maxWidth: .infinity, minHeight: 18, maxHeight: 18, alignment: .topTrailing)
            }
            HStack {
                Text("MOW")
                    .font(Font.custom("SF Pro Text", size: 13))
                    .foregroundColor(Color(red: 0.35, green: 0.39, blue: 0.45))
                    .frame(maxWidth: .infinity, minHeight: 16, maxHeight: 16, alignment: .topLeading)
                Text(convertDate("\(result.arrivalDateTime)"))
                    .font(Font.custom("SF Pro Text", size: 13))
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color(red: 0.35, green: 0.39, blue: 0.45))
            }
            HStack {
                Text("Санкт-Петербург")
                    .font(
                        Font.custom("SF Pro Text", size: 15)
                            .weight(.semibold)
                    )
                    .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
                    .frame(maxWidth: .infinity, minHeight: 18, maxHeight: 18, alignment: .topLeading)
                
                Text(formatTime("\(result.arrivalDateTime)"))
                    .font(
                        Font.custom("SF Pro Text", size: 15)
                            .weight(.semibold)
                    )
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
                    .frame(width: 65, height: 18, alignment: .topTrailing)
            }
            HStack  {
                Text("LED")
                    .font(Font.custom("SF Pro Text", size: 13))
                    .foregroundColor(Color(red: 0.35, green: 0.39, blue: 0.45))
                    .frame(maxWidth: .infinity, minHeight: 16, maxHeight: 16, alignment: .topLeading)
                Text(convertDate("\(result.arrivalDateTime)"))
                    .font(Font.custom("SF Pro Text", size: 13))
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color(red: 0.35, green: 0.39, blue: 0.45))
                    .frame(width: 65, height: 16, alignment: .topTrailing)
            }
            
        }
        .font(.title)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 110, trailing: 0))
        //.padding()
        .background(Color.white)
        .cornerRadius(12)
        
    }
    
    
    
    
}


func formatTime(_ dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    
    if let date = dateFormatter.date(from: dateString) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        return timeFormatter.string(from: date)
    } else {
        return "Invalid Date"
    }
}

func convertDate(_ dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    dateFormatter.locale = Locale(identifier: "ru_RU")
    
    let convertedDate = dateFormatter.date(from: dateString)
    
    let outputDateFormatter = DateFormatter()
    outputDateFormatter.dateFormat = "d MMM, E"
    outputDateFormatter.locale = Locale(identifier: "ru_RU")
    
    if let convertedDate = convertedDate {
        return outputDateFormatter.string(from: convertedDate)
    } else {
        return "Invalid Date"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(results: [], cheapestTiketID: "")
    }
}

