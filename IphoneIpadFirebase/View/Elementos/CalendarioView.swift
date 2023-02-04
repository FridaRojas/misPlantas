//
//  CalendarioView.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 13/01/23.
//

import SwiftUI

struct CalendarioView: View {
    var recordatorios : [RecordatorioModel]
    @Binding var fechaAct : Date
    @State var mesAct : Int = 0
    let dias: [String] = ["D","L","M","M","J","V","S"]
    
    var body: some View {
        VStack(spacing: 35){
            
            //año, mes
            HStack(spacing: 20){
                VStack(alignment: .leading, spacing: 10){
                    
                    Text(RecordatorioViewModel.shared.formaFecha(fechaAct: fechaAct)[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text(RecordatorioViewModel.shared.formaFecha(fechaAct: fechaAct)[1])
                        .font(.title.bold())
                        .foregroundColor(.black)
                }
                Spacer()
                Button{
                    withAnimation{
                        mesAct -= 1
                    }
                }label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        
                }/*.foregroundColor(RecordatorioViewModel.shared.obtieneMesActual(mesAct: mesAct) == RecordatorioViewModel.shared.obtieneMesActual(mesAct: 0) ? Color.gray : Color.blue)
                    .disabled(RecordatorioViewModel.shared.obtieneMesActual(mesAct: mesAct) == RecordatorioViewModel.shared.obtieneMesActual(mesAct: 0) ? true : false)*/
                
                Button{
                    withAnimation{
                        mesAct += 1
                    }
                }label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
                
            }.padding(.horizontal)
            
            //dias
            HStack(spacing: 0){
                ForEach(dias, id: \.self){ dia in
                    
                    Text(dia)
                        .font(.callout.bold())
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color("primario"))
                        .shadow(color: .white, radius: 2)
                    
                }
            }
            
            //numero de dias
            let columnas = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columnas,spacing: 15){
                ForEach(RecordatorioViewModel.shared.extraeFecha(mesAct: mesAct)){valueDia in
                    CardDia(recordatorios: recordatorios, value: valueDia)
                        .background(
                        Capsule()
                            .fill(Color("primario"))
                            .padding(.horizontal,8)
                            .opacity(RecordatorioViewModel.shared.esMismoDia(fecha1: valueDia.fecha, fecha2: fechaAct) ? 0.6 : 0)
                            .shadow(radius: RecordatorioViewModel.shared.esMismoDia(fecha1: valueDia.fecha, fecha2: fechaAct) ? 2 : 0)
                        )
                        .onTapGesture {
                            fechaAct = valueDia.fecha
                        }
                }
            }
            
            //Lista de tareas
            ListaRecordatoriosView(recordatorios: recordatorios, fechaAct: $fechaAct)
            
            Spacer(minLength: 50)
            
        }
        .onChange(of: mesAct){nuevoValor in
            //actualiza mes
            fechaAct = RecordatorioViewModel.shared.obtieneMesActual(mesAct: mesAct)
        }.onAppear{
            print("Entre al calendario")
        }
    }
}
