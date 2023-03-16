//
//  ComentariosView.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 15/03/23.
//

import SwiftUI

struct ComentariosView: View {
    @Binding var modal : Bool
    
    var body: some View {
        VStack(alignment: .center){
            Text("¡Hola!, puedes enviar un correo a: misPlantas@gmail.com con el asunto 'comentario MisPlantas', te agradecemos los comentarios :)").foregroundColor(Color("primario"))
            Text("misPlantas@gmail.com con el asunto 'comentario MisPlantas' te agradecemos los comentarios :)").foregroundColor(Color("primario")).bold()
            Text("te agradecemos los comentarios :)").foregroundColor(Color("primario"))
        }.background(Color.white)
        
    }
}

