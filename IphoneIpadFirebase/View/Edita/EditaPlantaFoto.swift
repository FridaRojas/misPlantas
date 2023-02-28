//
//  EditaPlantaFoto.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 25/01/23.
//

import SwiftUI

struct EditaPlantaFoto: View {
    var planta : PlantasModel
    var habitacion : HabitacionModel
    let itemRiego = ["Dias", "Semanas", "Meses"]
    @EnvironmentObject var loginShow : FirebaseViewModel
    @Binding var modal : Bool
    @State var errorFirebase = false
    @State private var fotoNueva : Data = .init(capacity: 0)
    @State private var nombreNuevo = ""
    @State private var riego : String = ""
    @State private var proxRiego: Date = Date()
    @State private var seleccionRiego: String = "Dias"
    @State private var seleccionHabitacion: String = "Sala de estar"
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    
    @State private var atras = false
    
    var body: some View {
            NavigationStack{
                VStack{
                    Text("Edita a \(planta.nombre) ")
                        .padding(.horizontal)
                        .font(.custom("Noteworthy", size: 35))
                        .foregroundColor(Color.black)
                    ScrollView{
                        //foto
                        VStack{
                            VStack{
                                Button(action:{
                                    mostrarMenu.toggle()
                                }){
                                    Text("Cambiar Imagen")
                                    //Image(systemName: "plus.app").resizable().frame(width: 80, height: 80).foregroundColor(Color("primario"))
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
                                
                                if fotoNueva.count != 0 {
                                    Image(uiImage: UIImage(data: fotoNueva)!)
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                        .cornerRadius(15)
                                }
                            }
                        }.padding()
                        
                        //Nombre
                        VStack{
                            Text("Nombre: ").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                            TextField(planta.nombre, text: $nombreNuevo).frame(width: 300, height: 40)
                                .background(Color.white).foregroundColor(.black).cornerRadius(10).shadow(radius: 2)
                        }.padding(.horizontal).onAppear{nombreNuevo = planta.nombre}
                        
                        //Riego
                        VStack{
                            Text("¿Cada cuanto se debe regar?").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                            HStack{
                                TextField("", text: $riego).keyboardType(.numberPad).frame(width: 50, height: 40).background(Color.white).foregroundColor(.black).cornerRadius(10).shadow(radius: 2).onAppear{riego = String(planta.riegoNum)}
                                Picker("Select one option", selection: $seleccionRiego) {
                                    ForEach(itemRiego, id: \.self) {item in
                                        Text(item)
                                    }
                                }.background(Color("primario")).cornerRadius(10).pickerStyle(SegmentedPickerStyle()).onAppear{seleccionRiego = planta.riegoPeriod}
                            }
                        }.padding()
                            .background(Color.white)
                            .cornerRadius(30)
                            .shadow(radius: 4)
                        
                        //siguiente Riego
                        VStack{
                            Text("Siguiente riego:").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                            DatePicker(
                                "Start Date",
                                selection: $proxRiego,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(.graphical).onAppear{proxRiego = planta.proxRecordatorio}
                            
                        }.padding()
                            .background(Color("primario").opacity(0.6))
                            .cornerRadius(30)
                            .shadow(radius: 4)
                        
                        
                        //Boton
                        Button(action:{
                            if fotoNueva.isEmpty{
                                loginShow.editarPlantaFotoNombre(idHabitacion: habitacion.id, Planta: planta, nombreNuevo: nombreNuevo, fotoNuevo: nil, riegoNum: Int(riego) ?? 0, riegoPeriod: seleccionRiego, siguienteRiego: proxRiego){(done) in
                                    if done{
                                        loginShow.plantaActual.nombre = nombreNuevo
                                        loginShow.plantaActual.riegoNum = Int(riego) ?? 0
                                        loginShow.plantaActual.riegoPeriod = seleccionRiego
                                        loginShow.plantaActual.proxRecordatorio = proxRiego
                                        atras.toggle()
                                        modal.toggle()
                                    }
                                }
                            }else{
                                loginShow.editarPlantaFotoNombre(idHabitacion: habitacion.id, Planta: planta, nombreNuevo: nombreNuevo, fotoNuevo: fotoNueva, riegoNum: Int(riego) ?? 0, riegoPeriod: seleccionRiego, siguienteRiego: proxRiego){(done) in
                                    if done{
                                        loginShow.plantaActual.nombre = nombreNuevo
                                        loginShow.plantaActual.riegoNum = Int(riego) ?? 0
                                        loginShow.plantaActual.riegoPeriod = seleccionRiego
                                        loginShow.plantaActual.proxRecordatorio = proxRiego
                                        //falta modificar foto
                                        atras.toggle()
                                        modal.toggle()
                                        
                                    }
                                }
                            }
                        }){
                            Text("Guardar").foregroundColor(.white).bold()
                        }.padding()
                            .background(Color("primario"))
                            .cornerRadius(8)
                            .shadow(radius: 4)
                        Spacer(minLength: 20)
                    }.padding()
                        .onTapGesture {
                            self.hideKeyboard()
                        }
                    
                    
                }.padding().background(LinearGradient(gradient: Gradient(colors: [Color("primario"), .white]), startPoint: .top, endPoint: .bottom)).ignoresSafeArea(.all)
                    .onAppear{
                        loginShow.obtienePlantas(idHabitacion: habitacion.id){ done in
                        } failure: { error in
                            errorFirebase = true
                        }
                    }
                    .navigationDestination(isPresented: $imagePicker){
                        ImagePicker(show: $imagePicker, image: $fotoNueva, source: source)
                    }
            }.ignoresSafeArea(.all)
    }
}

