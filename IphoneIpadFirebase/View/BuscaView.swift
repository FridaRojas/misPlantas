//
//  BuscaView.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 05/01/23.
//

import SwiftUI

struct BuscaView: View {
    @EnvironmentObject var loginShow : FirebaseViewModel
    @State var resultados = [Result]()
    @State var numError = 0
    @State var inicio = true
    @State var progress = false
    @State var errorPlantnet = false
    @State var foto : Data = .init(capacity: 0)
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera

    var body: some View {
        ZStack{
            
            NavigationStack{
                VStack{
                    Spacer(minLength: 150)
                    Text("Identifica tu planta")
                        .padding(.horizontal)
                        .font(.custom("Noteworthy", size: 30))
                        .foregroundColor(Color.white)
                        .shadow(color: .black,radius: 3)
                    Spacer(minLength: 50)
                    
                    if inicio {
                            //Botones
                            HStack(spacing: 50){
                                Spacer()
                                //Boton toma foto
                                Button(action:{
                                    mostrarMenu.toggle()
                                }){
                                    VStack{
                                        Text("Tomar foto").foregroundColor(Color("primario")).font(.footnote)
                                        Image(systemName: "camera.fill").font(.largeTitle)
                                            
                                    }.padding().frame(width: 100, height: 100)
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
                                    PlantNetViewModel.shared.obtieneLinkFoto(foto:foto) { resultado in
                                        resultados = resultado
                                        progress=false
                                    } failure: { error in
                                        progress=false
                                        errorPlantnet = true
                                        numError = error.asAFError?.responseCode ?? 500
                                    }
                                }){
                                    VStack{
                                        Text("Buscar").font(.footnote)
                                        Image(systemName: "magnifyingglass").font(.largeTitle)
                                            
                                    }.padding().frame(width: 100, height: 100)
                                        .foregroundColor(foto.count != 0 ? Color("primario") : Color.white.opacity(0.7))
                                        .background(foto.count != 0 ? Color.white : Color.gray.opacity(0.7)).cornerRadius(20)
                                        .shadow(radius: 4)
                                }.disabled(foto.count != 0 ? false : true)
                                
                                Spacer()
                            }
                           
                            Spacer(minLength: 50)
                            
                            //Muestra foto tomada
                            if foto.count != 0 {
                                VStack{
                                    Text("Imagen cargada:").padding(.horizontal)
                                        .font(.custom("Noteworthy", size: 15))
                                        .foregroundColor(Color.white)
                                    Image(uiImage: UIImage(data: foto)!)
                                        .resizable()
                                        .frame(width: 300, height: 300)
                                        .cornerRadius(15)
                                }
                            }else{
                                VStack{
                                    Text("Imagen cargada:").padding(.horizontal)
                                        .font(.custom("Noteworthy", size: 15))
                                        .foregroundColor(Color.white)
                                    Image(systemName: "camera.metering.center.weighted.average")
                                        .resizable()
                                        .frame(width: 250, height: 300)
                                        .cornerRadius(15)
                                }
                            }
                            Spacer()
                    }else{
                        if errorPlantnet {
                            VStack{
                                
                                if numError >= 400 && numError < 499{
                                    VStack{
                                        ImagenFirebase(imagenUrl: "gs://fir-crud-af577.appspot.com/imagenes/triste.png")
                                                .frame(width: 250,height: 250)
                                                .cornerRadius(20)
                                        Text("No se encontraron coincidencias").padding().foregroundColor(.white).shadow(radius: 3)
                                    }
                                }else{
                                    VStack{
                                        ImagenFirebase(imagenUrl: "gs://fir-crud-af577.appspot.com/imagenes/triste.png")
                                                .frame(width: 250,height: 250)
                                                .cornerRadius(20)
                                        Text("Hubo un error").padding().foregroundColor(.white).shadow(radius: 3)
                                    }
                                }
                                HStack{
                                    Spacer()
                                    
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
                                    
                                    Spacer()
                                }
                                Spacer(minLength: 100)
                            }
                        }else{
                            VStack{
                                Spacer()
                                Text("Posibles coincidencias:").padding(.horizontal)
                                    .font(.custom("Noteworthy", size: 20))
                                    .foregroundColor(Color.white)
                                    .shadow(color: .black,radius: 3)
                                ScrollView(.horizontal){
                                    HStack(spacing: 20){
                                        ForEach(0..<loginShow.limpiaResultados(resultados: resultados).count/*resultados.count*/, id: \.self) {item in
                                            //if resultados[item].species.commonNames.count() != 0{
                                                CardIdentifica(foto: resultados[item].images[0].url.o, nombres: resultados[item].species.commonNames)
                                            //}
                                        }
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
                    }
                    
                    Spacer(minLength: 150)
                }.background(Image("fondo2").resizable().opacity(0.8)).ignoresSafeArea(.all)
                    .navigationDestination(isPresented: $imagePicker){
                        ImagePicker(show: $imagePicker, image: $foto, source: source)
                    }
            }
            
            if progress {
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        VStack{
                            Image("carga")
                                .resizable().frame(width: 150, height: 150)
                            Text("Identificando tu plata...").background(Color.white)
                        }.padding().background(Color.white).cornerRadius(15)
                        Spacer()
                    }
                    Spacer()
                }.background(Color.white.opacity(0.9)).ignoresSafeArea(.all)
            }
        }
        
    }
}

