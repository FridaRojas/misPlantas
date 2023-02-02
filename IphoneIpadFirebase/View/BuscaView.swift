//
//  BuscaView.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 05/01/23.
//

import SwiftUI

struct BuscaView: View {
    @State var resultados = [Result]()
    @State var inicio = true
    @State var progress = false
    @State var foto : Data = .init(capacity: 0)
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera

    var body: some View {
        ZStack{
            
            NavigationStack{
                VStack{
                    Spacer(minLength: 50)
                    Text("Toma una foto e identifica tu planta")
                        .padding(.horizontal)
                        .font(.custom("Noteworthy", size: 30))
                        .foregroundColor(Color.gray)
                    Spacer(minLength: 25)
                    
                    if inicio {
                        VStack{
                            //Botones
                            HStack(spacing: 50){
                                //Boton toma foto
                                Button(action:{
                                    mostrarMenu.toggle()
                                }){
                                    VStack{
                                        Text("Tomar foto").foregroundColor(Color("primario"))
                                        Image(systemName: "camera.fill").padding().font(.largeTitle)
                                            
                                    }.frame(width: 100, height: 100)
                                        .foregroundColor(Color("primario"))
                                        .background(.white).cornerRadius(20)
                                        .shadow(radius: 4)
                                }.actionSheet(isPresented: $mostrarMenu) {
                                    ActionSheet(title: Text("Seleccione"), buttons: [
                                        .default(Text("Camara"), action: {
                                            source = .camera
                                            imagePicker.toggle()
                                        }),
                                        .default(Text("Galeria"), action: {
                                            source = .photoLibrary
                                            imagePicker.toggle()
                                        }),
                                        .default(Text("Cancelar"))
                                    ])
                                }
                                
                                //Boton desata API
                                Button(action:{
                                    inicio = false
                                    progress=true
                                    PlantNetViewModel.shared.getPlanta(imagen: "https://fichas.infojardin.com/foto-cactus/cereus-peruvianus-monstruos.jpg") { resultado in
                                        resultados = resultado
                                        progress=false
                                    } failure: { error in
                                        progress=false
                                        Text("Error: ")
                                    }
                                    /*PlantNetViewModel.shared.getPlanta(imagen: "https://www.cactusysuculentas.org/wp-content/uploads/2018/01/cactus-cerebro7.jpg")*/
                                }){
                                    VStack{
                                        Text("Buscar")
                                        Image(systemName: "magnifyingglass").padding().font(.largeTitle)
                                            
                                    }.frame(width: 100, height: 100)
                                        .foregroundColor(foto.count != 0 ? Color("primario") : Color.white.opacity(0.7))
                                        .background(foto.count != 0 ? Color.white : Color.gray.opacity(0.7)).cornerRadius(20)
                                        .shadow(radius: 4)
                                }.disabled(foto.count != 0 ? false : true)
                            }
                           
                            Spacer()
                            
                            //Muestra foto tomada
                            if foto.count != 0 {
                                VStack{
                                    Text("Imagen cargada:").padding(.horizontal)
                                        .font(.custom("Noteworthy", size: 15))
                                        .foregroundColor(Color.gray)
                                    Image(uiImage: UIImage(data: foto)!)
                                        .resizable()
                                        .frame(width: 200, height: 200)
                                        .cornerRadius(15)
                                }
                            }else{
                                VStack{
                                    Text("Imagen cargada:").padding(.horizontal)
                                        .font(.custom("Noteworthy", size: 15))
                                        .foregroundColor(Color.gray)
                                    Image(systemName: "camera.metering.center.weighted.average")
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                        .cornerRadius(15)
                                }
                            }
                            Spacer()
                        }
                    }else{
                        VStack{
                            Spacer()
                            Text("Coincidencias:").padding(.horizontal)
                                .font(.custom("Noteworthy", size: 15))
                                .foregroundColor(Color.gray)
                            ScrollView(.horizontal){
                                VStack{
                                    ForEach(0..<resultados.count, id: \.self) {item in
                                        CardIdentifica(foto: resultados[item].images[0].url.o, nombres: resultados[item].species.commonNames)
                                    }
                                    /*ForEach(resultados, id: \.self){item in
                                        CardIdentifica(foto: item.images.urls, nombres: item.species.commonNames)
                                    }*/
                                }
                                
                            }
                            Spacer()
                        }
                        //Boton de Nuevo
                        Button(action:{
                            resultados = [Result]()
                            foto = .init(capacity: 0)
                            mostrarMenu = false
                            imagePicker = false
                            inicio = true
                        }){
                           Text("De Nuevo")
                        }.padding()
                            .frame(width: 120, height: 80)
                            .foregroundColor(Color("primario"))
                            .background(.white).cornerRadius(20)
                        
                    }
                    
                    Spacer(minLength: 100)
                }.navigationDestination(isPresented: $imagePicker){
                    ImagePicker(show: $imagePicker, image: $foto, source: source)
                }
            }.background(Image("fondo1").resizable()).ignoresSafeArea(.all)
            if progress {
                HStack{
                    Spacer()
                    VStack{
                        Spacer()
                        Image("carga")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .background(Color.white)
                            .cornerRadius(15)
                        Spacer()
                    
                    }
                    Spacer()
                }.background(Color.white.opacity(0.9)).ignoresSafeArea(.all)
            }
        }.background(Image("fondo1").resizable()).ignoresSafeArea(.all)
        
    }
}

