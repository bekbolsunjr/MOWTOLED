import SwiftUI

struct DetailView: View {
    
    @State var result: Result
    @State private var showAlert = false
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                HStack{
                    Text("\(result.price.value)")
                        .font(Font.custom("SF Pro Display", size: 34))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
                        .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40, alignment: .top)
                        .fontWeight(.bold)
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
                        .font(Font.custom("SF Pro Text", size: 17))
                        .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
                        .frame(maxWidth: .infinity, minHeight: 20, maxHeight: 20, alignment: .topLeading)
                        .padding(.leading, 20)
                    
                }
                List(0 ..< 1) { item in
                    
                    HStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 32, height: 32)
                            .background(
                                
                                Image("S7OnDarkTrue")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 32, height: 32)
                                    .clipped()
                            )
                            .cornerRadius(32)
                        
                        Text("\(result.airline)")
                            .font(
                                Font.custom("SF Pro Text", size: 15)
                                    .weight(.semibold)
                            )
                            .foregroundColor(Color(red: 0.05, green: 0.07, blue: 0.11))
                            .frame(maxWidth: .infinity, minHeight: 18, maxHeight: 18, alignment: .topLeading)
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
                }
                .listRowSeparator(.hidden)
                
                HStack{
                    Button("Купить билет за \(result.price.value)"){
                        showAlert = true
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: 48, alignment: .center)
                    .background(Color(red: 1, green: 0.44, blue: 0.2))
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 0)
                    .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 8)
                    .foregroundColor(.white)

                    .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Билет куплен за \(result.price.value)"),
                                    dismissButton: .default(Text("Отлично"))
                                )
                            }
                }
            }
        }
    }
}
