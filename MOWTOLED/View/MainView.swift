import Foundation
import SwiftUI


struct MainView: View {
    @State var results: [Tiket] = []
    @State var cheapestTiketID: String
    @State var isLoading = false
    
    
    var body: some View {
        
        NavigationView {
            VStack{
                CustomNavigationTitle()

                List(results, id: \.id) { result in
                    NavigationLink(destination: DetailView(result: result)){
                        cell(result: result)
                    }
                    
                    .listStyle(InsetListStyle())
                    .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 15, trailing: 0))
                    .listRowBackground(Color.clear)
                    .background(Color.white)
                    .cornerRadius(12)
                }
                .navigationTitle("Все билеты")
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .onAppear{ loadResults(); startFaceNetworkCall()}
                
                if isLoading {
                    LoadingView()
                }
                
            }

        }

    }
    
    
    func loadResults() {
        APIManager.shared.getTiket { results in
            self.results = results.sorted { $0.price.value < $1.price.value }
            cheapestTiketID = self.results[0].id
        }
    }
    
    
    
    
    @ViewBuilder
    
    func cell(result: Tiket) -> some View {
        
        VStack(alignment: .leading){
            
            HStack { // бейдик самый дешовый
                if cheapestTiketID == result.id {
                    Text("Самый дешёвый")
                        .font(Font.custom("SF Pro Text", size: 13).weight(.semibold))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 0)
                        .frame(height: 20, alignment: .leading)
                        .background(Color(red: 0.21, green: 0.78, blue: 0.41))
                        .cornerRadius(100)
                    
                }
            }

            if #available(iOS 15.0, *) {
                HStack { // цена, лого авия комании
                    
                    Text("\(formatNumber(result.price.value)) ₽")
                        .font( Font.custom("SF Pro Text", size: 19).weight(.semibold))
                        .foregroundColor(Color(red: 0.05, green: 0.45, blue: 1))
                        .frame(maxWidth: .infinity, minHeight: 23, maxHeight: 23, alignment: .topLeading)
                    
                    Group {
                        if result.airline == "Аэрофлот" {
                            Image("AeroflotOnDarkFalse")
                        } else if result.airline == "Победа" {
                            Image("PobedaOnDarkFalse")
                        } else if result.airline == "Smartavia" {
                            Image("SmartAvOnDarkFalse")
                        } else if result.airline == "S7" {
                            Image("S7OnDarkFalse")
                        }
                    }
                    .padding(.bottom, 10)
                    .frame(width: 26, height: 26, alignment: .trailing)
                    
                    
                } .padding(10)
                    .listRowSeparator(.hidden)
            } else {
                // Fallback on earlier versions
            }
            
            
            HStack { // осталось билетов
                
                if result.availableTicketsCount <= 10 {
                    Text("Осталось \(result.availableTicketsCount) билетов по этой цене")
                        .font(Font.custom("SF Pro Text", size: 13))
                        .foregroundColor(Color(red: 0.87, green: 0.26, blue: 0.31))
                        .frame(maxWidth: .infinity, minHeight: 0, maxHeight: 16, alignment: .topLeading)
                }
            }
            
            HStack { // От куда? , время
                Text("Москва")
                    .font(Font.custom("SF Pro Text", size: 15).weight(.semibold))
                    .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
                    .frame(maxWidth: .infinity, minHeight: 18, maxHeight: 18, alignment: .topLeading)
                
                Text(formatTime("\(result.arrivalDateTime)")) // Время вылета
                    .font(Font.custom("SF Pro Text", size: 15).weight(.semibold))
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
                    .frame(maxWidth: .infinity, minHeight: 18, maxHeight: 18, alignment: .topTrailing)
            }
            HStack {
                Text("MOW")
                    .font(Font.custom("SF Pro Text", size: 13))
                    .foregroundColor(Color(red: 0.35, green: 0.39, blue: 0.45))
                    .frame(maxWidth: .infinity, minHeight: 16, maxHeight: 16, alignment: .topLeading)
                Text(convertDate("\(result.arrivalDateTime)")) // дата вылета
                    .font(Font.custom("SF Pro Text", size: 13))
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color(red: 0.35, green: 0.39, blue: 0.45))
            }
            HStack {
                Text("Санкт-Петербург")
                    .font(Font.custom("SF Pro Text", size: 15).weight(.semibold))
                    .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
                    .frame(maxWidth: .infinity, minHeight: 18, maxHeight: 18, alignment: .topLeading)
                
                Text(formatTime("\(result.arrivalDateTime)"))
                    .font(Font.custom("SF Pro Text", size: 15).weight(.semibold))
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
        .padding()
        .cornerRadius(12)
        
        
    }
    
    func startFaceNetworkCall(){
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isLoading = false
        }
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
func formatNumber(_ number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        return numberFormatter.string(from: NSNumber(value: number)) ?? ""
    }



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(results: [], cheapestTiketID: "")
    }
}


struct LoadingView: View {
    var body: some View {
        ZStack(alignment: .center){
            Color(.systemBackground)
                .ignoresSafeArea()
                .opacity(0.5)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(3)
        }
    }
}
