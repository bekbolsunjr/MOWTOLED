import SwiftUI

struct DetailView: View {
    
    @State var result: Tiket
    @State private var showAlert = false
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("\(formatNumber(result.price.value)) ₽")
                        .font(.system(size: 34, weight: .bold))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
                        .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40, alignment: .top)
                    
                }
                HStack{
                    Text("Лучшая цена за 1 чел")
                    
                        .font(Font.custom("SF Pro Text", size: 13))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
                        .frame(maxWidth: .infinity, minHeight: 15, maxHeight: 15, alignment: .top)
                }
                HStack{
                    Text("Москва — Санкт-Петербург")
                        .font(.system(size: 13, weight: .bold))
                    //.font(Font.custom("SF Pro Text", size: 17))
                        .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
                        .frame(maxWidth: .infinity, minHeight: 20, maxHeight: 20, alignment: .topLeading)
                        .padding(.leading, 20)
                    
                }
                if #available(iOS 15.0, *) {
                    List(0 ..< 1) { item in
                        if #available(iOS 15.0, *) {
                            HStack{
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
                                
                                Text("\(result.airline)")
                                    .font(
                                        Font.custom("SF Pro Text", size: 15)
                                            .weight(.semibold)
                                    )
                                    .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
                                    .frame(maxWidth: .infinity, minHeight: 18, maxHeight: 18, alignment: .topLeading)
                            }
                            .listRowSeparator(.hidden)
                        } else {
                            // Fallback on earlier versions
                        }
                        
                        
                        HStack{
                            Text("Москва")
                                .font(
                                    Font.custom("SF Pro Text", size: 15)
                                        .weight(.semibold)
                                )
                                .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
                                .frame(maxWidth: .infinity, minHeight: 18, maxHeight: 18, alignment: .topLeading)
                            
                            Text(formatTime(result.arrivalDateTime))
                                .font(
                                    Font.custom("SF Pro Text", size: 15)
                                        .weight(.semibold)
                                )
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
                                .frame(maxWidth: .infinity, minHeight: 18, maxHeight: 18, alignment: .topTrailing)
                        }
                        .listRowSeparator(.hidden)
                        HStack{
                            Text("MOW")
                                .font(Font.custom("SF Pro Text", size: 13))
                                .foregroundColor(Color(red: 0.35, green: 0.39, blue: 0.45))
                                .frame(maxWidth: .infinity, minHeight: 16, maxHeight: 16, alignment: .topLeading)
                            Text(convertDate(result.arrivalDateTime))
                                .font(Font.custom("SF Pro Text", size: 13))
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(Color(red: 0.35, green: 0.39, blue: 0.45))
                        }
                        .listRowSeparator(.hidden)
                        HStack{
                            Text("Санкт-Петербург")
                                .font(
                                    Font.custom("SF Pro Text", size: 15)
                                        .weight(.semibold)
                                )
                                .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
                                .frame(maxWidth: .infinity, minHeight: 18, maxHeight: 18, alignment: .topLeading)
                            Text(formatTime(result.departureDateTime))
                                .font(
                                    Font.custom("SF Pro Text", size: 15)
                                        .weight(.semibold)
                                )
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
                                .frame(width: 65, height: 18, alignment: .topTrailing)
                        }
                        .listRowSeparator(.hidden)
                        HStack{
                            Text("LED")
                                .font(Font.custom("SF Pro Text", size: 13))
                                .foregroundColor(Color(red: 0.35, green: 0.39, blue: 0.45))
                                .frame(maxWidth: .infinity, minHeight: 16, maxHeight: 16, alignment: .topLeading)
                            Text(convertDate(result.departureDateTime))
                                .font(Font.custom("SF Pro Text", size: 13))
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(Color(red: 0.35, green: 0.39, blue: 0.45))
                                .frame(width: 65, height: 16, alignment: .topTrailing)
                        }
                        .listRowSeparator(.hidden)
                    }
                    
                    .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 15, trailing: 0))
                    .listRowBackground(Color.clear)
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding()
                    .listRowSeparator(.hidden)
                    .listStyle(InsetListStyle())
                } else {
                    // Fallback on earlier versions
                }
                
                Button(action: {
                    showAlert = true
                }) {
                    Text("Купить билет за \(formatNumber(result.price.value))")
                        .frame(maxWidth: .infinity, maxHeight: 48)
                        .font(Font.custom("SF Pro Text", size: 17).weight(.semibold))
                        .background(Color(red: 1, green: 0.44, blue: 0.2))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 8)
                }
                .padding(.horizontal, 16)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Билет куплен за \(formatNumber(result.price.value))")
                            .font(Font.custom("SF Pro Text", size: 17).weight(.semibold)),
                        
                        dismissButton: .default(Text("Отлично"))
                    )
                }
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
    
}
