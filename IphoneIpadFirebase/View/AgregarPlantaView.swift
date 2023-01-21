//
//  AgregarView.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 05/01/23.
//

import SwiftUI

struct AgregarPlantaView: View {
    
    @State var nombrePlanta : String = ""
    @State var riego : String = ""
    @State private var seleccionIluminacion = "Sol"
    @State private var seleccionRiego: String = "Dias"
    @State private var seleccionAbono: String = "Semanas"
    @State private var seleccionHabitacion: String = "Sala de estar"
    @State private var proxRiego: Date = Date()
    @State private var abono : String = ""
    @State private var imagen1 : Data = .init(capacity: 0)
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    
    let itemIluminacion = ["Sol", "Sombra", "Ambos"]
    let itemRiego = ["Dias", "Semanas", "Meses"]
    let itemAbono = ["Semanas", "Meses"]
    let itemHabitacion = ["Recamara", "Sala", "Comedor", "Cocina", "Jardin", "Balcon"]
    @EnvironmentObject var loginShow : FirebaseViewModel
    
    var body: some View {
        
        NavigationView {
            VStack {
                NavigationLink(destination: ImagePicker(show: $imagePicker, image: $imagen1, source: source), isActive: $imagePicker){
                    EmptyView()
                }.navigationBarHidden(true)
                
                Spacer(minLength: 50)
                Text("Datos de tu planta:").font(.custom("Noteworthy", size: 40)).foregroundColor(.gray)
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                    //Spacer(minLength: 20)
                    VStack(alignment: .leading){
                        VStack{
                            //añade fotos
                            VStack{
                                Text("Añade fotos").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                                HStack{
                                    Spacer()
                                    Button(action:{
                                        mostrarMenu.toggle()
                                    }){
                                        Text("Cargar Imagen")
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
                                    
                                    if imagen1.count != 0 {
                                        Image(uiImage: UIImage(data: imagen1)!)
                                            .resizable()
                                            .frame(width: 150, height: 150)
                                            .cornerRadius(15)
                                    }
                                    
                                    Spacer()
                                }
                            }.padding()
                            .background(Color.white)
                            .cornerRadius(30)
                            .shadow(radius: 4)
                            
                            Spacer(minLength: 20)
                            //nombre
                            VStack{
                                Text("Nombre o apodo:").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                                TextField("", text: $nombrePlanta).frame(width: 300, height: 40)
                                    .background(Color.white).foregroundColor(.black).cornerRadius(10).shadow(radius: 2)
                            }.padding()
                                .background(Color.white)
                                .cornerRadius(30)
                                .shadow(radius: 4)
                            Spacer(minLength: 20)
                            //riego
                            VStack{
                                Text("¿Cada cuanto se debe regar?").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                                HStack{
                                    TextField("", text: $riego).keyboardType(.numberPad).frame(width: 50, height: 40).background(Color.white).foregroundColor(.black).cornerRadius(10).shadow(radius: 2)
                                    Picker("Select one option", selection: $seleccionRiego) {
                                        ForEach(itemRiego, id: \.self) {item in
                                            Text(item)
                                        }
                                    }.background(Color("primario")).cornerRadius(10).pickerStyle(SegmentedPickerStyle())
                                }
                            }.padding()
                                .background(Color.white)
                                .cornerRadius(30)
                                .shadow(radius: 4)
                            
                            Spacer(minLength: 20)
                        }
                        VStack{
                            //sol
                            VStack{
                                    Text("Iluminacion adecuada").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                                    Picker("Select one option", selection: $seleccionIluminacion) {
                                        ForEach(itemIluminacion, id: \.self) {item in
                                            Text(item)
                                        }
                                    }.background(Color("primario")).cornerRadius(10).pickerStyle(SegmentedPickerStyle())
                            }.padding()
                                .background(Color.white)
                                .cornerRadius(30)
                                .shadow(radius: 4)
                            Spacer(minLength: 20)
                            
                            //abono
                            VStack{
                                Text("¿Cada cuanto necesita Abono?").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                                HStack{
                                    TextField("", text: $abono).keyboardType(.numberPad).frame(width: 50, height: 40).background(Color.white).foregroundColor(.black).cornerRadius(10).shadow(radius: 2)
                                    Picker("Select one option", selection: $seleccionAbono) {
                                        ForEach(itemAbono, id: \.self) { item in
                                            Text(item)
                                        }
                                    }.background(Color("primario")).cornerRadius(10).pickerStyle(SegmentedPickerStyle())
                                }
                            }.padding()
                                .background(Color.white)
                                .cornerRadius(30)
                                .shadow(radius: 4)
                            Spacer(minLength: 20)
                            
                            //siguiente Riego
                            VStack{
                                Text("Siguiente riego:").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                                DatePicker(
                                        "Start Date",
                                        selection: $proxRiego,
                                        displayedComponents: [.date]
                                    )
                                .datePickerStyle(.graphical)
                                
                            }.padding()
                                .background(Color("primario").opacity(0.6))
                                .cornerRadius(30)
                                .shadow(radius: 4)
            
                            
                            //habitacion
                            VStack{
                                    Text("¿En que habitacion se encuentra?").font(.custom("Noteworthy", size: 15)).foregroundColor(.black)
                                    Picker("Select one option", selection: $seleccionHabitacion) {
                                        ForEach(loginShow.devuelveNombres(), id: \.self) {item in
                                            Text(item).foregroundColor(Color("primario"))
                                        }
                                    }.pickerStyle(.wheel)
                            }.padding()
                                .background(Color.white)
                                .cornerRadius(30)
                                .shadow(radius: 4)
                            
                            Spacer(minLength: 20)
                            
                            Button(action:{
                                loginShow.AgregarPlantas(idHabitacion: loginShow.devuelveId(nombre: seleccionHabitacion), nombre: nombrePlanta, foto: imagen1, iluminacion: seleccionIluminacion, riegoNum: Int(riego) ?? 0, riegoPeriod: seleccionRiego, abonoNum: Int(abono) ?? 0, abonoPeriod: seleccionRiego, proxRecordatorio: proxRiego){ (done) in
                                    if done{
                                        nombrePlanta = ""
                                        imagen1 = .init(capacity: 0)
                                        riego = ""
                                        seleccionIluminacion = "Sol"
                                        seleccionRiego = "Dias"
                                        seleccionAbono = "Semanas"
                                        seleccionHabitacion = "Recamara"
                                        proxRiego = Date()
                                        abono = ""
                                    }
                                    

                                }
                            }){
                                Text("Guardar").foregroundColor(.white).bold()
                            }.padding()
                                .background(imagen1.count != 0 ? Color("primario") : Color.gray.opacity(0.7))
                                .cornerRadius(8)
                                .shadow(radius: 4)
                                .disabled(imagen1.count != 0 ? false : true)
                            
                            Spacer(minLength: 100)
                        }
                        
                    }.padding()
                }.padding()
            }.background(Image("fondo1").resizable())
                .edgesIgnoringSafeArea(.all)
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}

