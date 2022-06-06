//
//  EmployeeVM.swift
//  CoreDataDemo
//
//  Created by Shridevi Sawant on 02/06/22.
//

import Foundation

class EmployeeVM {
    
    // strong reference of Model
    
    let dbUtil = DBUtility()
    var empList : [Employee] = []
    
    func addEmp(empName: String, id: Int, empCity: String, sal: Int){
        
        dbUtil.addEmployee(name: empName, empId: id, city: empCity, salary: sal)
    }
    
    func getEmp(){
        
        empList = dbUtil.getAllEmployees()
    }
    
    func deleteEmp(empToDelete: Employee){
        
        dbUtil.deleteEmp(emp: empToDelete)
    }
    
    func sortEmpByName(){
        empList = dbUtil.getEmpSortByName()
    }
    
    func sortEmpBySal(){
        empList = dbUtil.getEmpSortBySalary()
    }
    
    func filterEmpByCity(city: String){
        
        empList = dbUtil.getEmpFilterByCity(cityName: city)
    }
    
    func filterEmpBySalary(minSalary : Int){
        
        empList = dbUtil.getEmpFilterBySalary(salary: minSalary)
    }
}
