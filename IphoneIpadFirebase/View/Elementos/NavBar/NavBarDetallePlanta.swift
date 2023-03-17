//
//  NavBar.swift
//  IphoneIpadFirebase
//
//  Created by Jorge Maldonado Borbón on 19/01/21.
//

import SwiftUI

struct NavBarDetallePlanta: View {
    var planta : PlantasModel
    var idHabitacion : HabitacionModel
    var device = UIDevice.current.userInterfaceIdiom
    @State var modalEditaFoto = false
    @State var alertaElimina = false
    @EnvironmentObject var loginShow : FirebaseViewModel
    
    var body: some View {
        VStack {
            Spacer(minLength: 50)
            HStack(spacing: 10){
                Spacer()
                Button(action:{
                    alertaElimina = true
                }){
                    Image(systemName: "trash.fill").padding()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                        .background(Color.white)
                        .cornerRadius(15)
                }.alert(isPresented: $alertaElimina, content: {
                    Alert(title: Text("Eliminar"),
                          message: Text("¿Estas seguro de eliminar a \(planta.nombre)?"),
                          primaryButton: Alert.Button.destructive(Text("Aceptar"), action: {
                        loginShow.eliminarPlanta(item: planta, idHabitacion: idHabitacion.id)
                        loginShow.NavegacionHabitacion = false
                    }),
                          secondaryButton: .default(Text("Cancelar")))
                })
                
                Button(action:{
                    modalEditaFoto = true
                }){
                    Image(systemName: "square.and.pencil").padding()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.orange)
                            .background(Color.white)
                            .cornerRadius(15)
                }.sheet(isPresented: $modalEditaFoto){
                        EditaPlantaFoto(planta: planta, habitacion: idHabitacion,modal: $modalEditaFoto)
                    }
            }
            Spacer(minLength: 150)
            HStack{
                Text(planta.nombre)
                    .font(.custom("Noteworthy", size: 40))
                    .bold()
                    .foregroundColor(.white)
                    .font(.system(size: device == .phone ? 25 : 35))
                    .shadow(radius: 5)
                Spacer()
                
            }.padding()
        }.padding()//(.top, 250)
            .background(ImagenFirebase(imagenUrl:planta.foto).frame(width: 400, height: 400))
            .cornerRadius(30)
            .shadow(radius: 10)
            .ignoresSafeArea(.all)
    }
}


