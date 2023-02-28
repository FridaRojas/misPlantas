//
//  RecordatorioViewModel.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 03/02/23.
//

import Foundation

final class RecordatorioViewModel{
    static let shared = RecordatorioViewModel()
    
    func esMismoDia(fecha1: Date, fecha2: Date)->Bool{
        let calendario = Calendar.current
        return calendario.isDate(fecha1, inSameDayAs: fecha2)
    }
    func formaFecha(fechaAct : Date)->[String]{
        let formato = DateFormatter()
        formato.dateFormat = "YYYY MMMM"
        
        let fecha = formato.string(from: fechaAct)
        
        return fecha.components(separatedBy: " ")
    }
    func obtieneMesActual(mesAct : Int)->Date{
        let calendario = Calendar.current
        // obtiene mes actual
        guard let mesActual = calendario.date(bySetting: .month, value: mesAct, of: Date()) else{
            return Date()
        }
        return mesActual
    }
    func extraeFecha(mesAct : Int)->[FechaModel]{
        let calendario = Calendar.current
        // obtiene mes actual
        let mesActual = obtieneMesActual(mesAct: mesAct)
        
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
    func sumaPeriodo(diaActual : Date, numSuma : Int, periodo: String)->Date{
        let calendar = Calendar.current
        switch periodo{
        case "Dias":
            return calendar.date(byAdding: .day, value: numSuma, to: diaActual) ?? Date()
        case "Semanas":
            let numSuma = numSuma * 7
            return calendar.date(byAdding: .day, value: numSuma, to: diaActual) ?? Date()
        case "Meses":
            return calendar.date(byAdding: .month, value: numSuma, to: diaActual) ?? Date()
        default:
            return Date()
        }
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

