//
//  CalendarioView.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 13/01/23.
//

import SwiftUI

struct CalendarioView: View {
    @Binding var fechaAct : Date
    @State var mesAct : Int = 0
    let dias: [String] = ["D","L","M","M","J","V","S"]
    
    var body: some View {
        VStack(spacing: 35){
            
            //año, mes
            HStack(spacing: 20){
                VStack(alignment: .leading, spacing: 10){
                    
                    Text(formaFecha()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text(formaFecha()[1])
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
                }
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
                ForEach(extraeFecha()){valueDia in
                    CardView(value: valueDia)
                        .background(
                        Capsule()
                            .fill(Color("primario"))
                            .padding(.horizontal,8)
                            .opacity(esMismoDia(fecha1: valueDia.fecha, fecha2: fechaAct) ? 0.6 : 0)
                            .shadow(radius: esMismoDia(fecha1: valueDia.fecha, fecha2: fechaAct) ? 2 : 0)
                        )
                        .onTapGesture {
                            fechaAct = valueDia.fecha
                        }
                }
            }
            
            //Lista de tareas
            VStack(spacing: 20){
                Text("Recordatorios")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .foregroundColor(Color("primario"))
                    .shadow(color: .white, radius: 3)
                
                if let tarea = tareas.first(where: { tarea in
                    return esMismoDia(fecha1: tarea.fecha, fecha2: fechaAct)
                }){
                    ForEach(tarea.tareas){ t in
                        VStack(alignment: .leading, spacing: 10){
                            Text(t.planta)
                                .font(.title2.bold())
                                .foregroundColor(.black)
                            Text(t.tipo)
                                .font(.title2)
                                .foregroundColor(.black)
                        }.padding(.vertical)
                            .frame( maxWidth: .infinity, alignment: .leading)
                            .background(Color("primario"))
                            .cornerRadius(10)
                    }
                }else{
                    Text("No se encontraron").foregroundColor(.gray)
                }
            }
            .padding()
            
            Spacer(minLength: 50)
            
        }
        .onChange(of: mesAct){nuevoValor in
            //actualiza mes
            fechaAct = obtieneMesActual()
        }
    }
    @ViewBuilder
    func CardView(value: FechaModel) -> some View{
        VStack{
            if value.dia != -1{
                if let task = tareas.first(where: { tarea in
                    
                    return esMismoDia(fecha1: tarea.fecha, fecha2: value.fecha)
                }){
                    Text("\(value.dia)")
                        .font(.title3.bold())
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                    Spacer()
                    Circle()
                        .fill(Color("primario"))
                        .frame(width: 8, height: 8)
                }
                else{
                    Text("\(value.dia)")
                        .font(.title3.bold())
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
                
            }
        }.padding(.vertical, 8)
            .frame(height: 60, alignment: .top)
    }
    func esMismoDia(fecha1: Date, fecha2: Date)->Bool{
        let calendario = Calendar.current
        return calendario.isDate(fecha1, inSameDayAs: fecha2)
    }
    func formaFecha()->[String]{
        let formato = DateFormatter()
        formato.dateFormat = "YYYY MMMM"
        
        let fecha = formato.string(from: fechaAct)
        
        return fecha.components(separatedBy: " ")
    }
    func obtieneMesActual()->Date{
        let calendario = Calendar.current
            // obtiene mes actual
        guard let mesActual = calendario.date(bySetting: .month, value: self.mesAct, of: Date()) else{
            return Date()
        }
        return mesActual
    }
    func extraeFecha()->[FechaModel]{
        let calendario = Calendar.current
            // obtiene mes actual
        let mesActual = obtieneMesActual()
        
        var dias = mesActual.getAllDates().compactMap { fecha -> FechaModel in
            //obtiene dia
            let dia = calendario.component(.day, from: fecha)
            
            return FechaModel(dia: dia, fecha: fecha)
        }
        // para que coincidan los dias con los dias de a semana
        let primerDiaSemana = calendario.component(.weekday, from: dias.first?.fecha ?? Date())
        for _ in 0..<primerDiaSemana - 1 {
            dias.insert(FechaModel(dia : -1, fecha: Date()), at: 0)
        }
        return dias
    }
}

extension Date{
    func getAllDates()->[Date]{
        let calendario = Calendar.current
        let fechaInicio = calendario.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        let rango = calendario.range(of: .day, in: .month, for: fechaInicio)!
        
        
        return rango.compactMap{ day -> Date in
            return calendario.date(byAdding: .day, value: day - 1 , to: fechaInicio)!
        }
    }
}
