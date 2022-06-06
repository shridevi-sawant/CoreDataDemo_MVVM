//
//  DBUtilities.swift
//  CoreDataDemo
//
//  Created by Shridevi Sawant on 28/04/22.
//

import Foundation
import UIKit
import CoreData

class DBUtility {
    
    let mContext = (UIApplication.shared.delegate as!  AppDelegate).persistentContainer.viewContext
    
    func addEmployee(name: String, empId: Int, city: String, salary: Int){
        
        // insert row
        
        let emp = Employee(context: mContext)
        
        emp.name = name
        emp.emp_id = Int64(empId)
        emp.city = city
        emp.salary = Int64(salary)
        emp.joining_date = Date()
        
        do {
            try mContext.save() // insertion happeing
            
            print("Emp added..")
        }catch {
            print("Unable to add employee: \(error.localizedDescription)")
            mContext.delete(emp)
        }
        
    }
    
    func getAllEmployees() -> [Employee] {
        // select * from Employee
        
        let fReq : NSFetchRequest<Employee> = Employee.fetchRequest()
        
        do {
            let empList = try mContext.fetch(fReq) // select query executed
            return empList
            
        }catch {
            print("Could not query: \(error.localizedDescription)")
        }
        
        return []
    }
    
    func deleteEmp(emp: Employee){
        // delete
        
        mContext.delete(emp)
        do {
            try mContext.save()
            print("Deleted \(emp.name ?? "" )")
        }catch {
            print("Could not delete \(emp.name ?? "")")
        }
    }
    
    func getEmpSortByName() -> [Employee] {
        let fReq : NSFetchRequest<Employee> = Employee.fetchRequest()
        
        let nameSortDes = NSSortDescriptor(key: "name", ascending: true)
        
        fReq.sortDescriptors = [nameSortDes]
        do {
            let emps = try mContext.fetch(fReq)
            return emps
        }catch {
            print("getEmpSortByName: Could not fetch ")
        }
        
        return []
    }
    
    func getEmpSortBySalary() -> [Employee] {
        let fReq : NSFetchRequest<Employee> = Employee.fetchRequest()
        
        let salSortDes = NSSortDescriptor(key: "salary", ascending: false)
        
        fReq.sortDescriptors = [salSortDes]
        do {
            let emps = try mContext.fetch(fReq)
            return emps
        }catch {
            print("getEmpSortBySalary: Could not fetch ")
        }
        
        return []
    }
    
    func getEmpFilterByCity(cityName: String) -> [Employee] {
        
        let fReq = Employee.fetchRequest()
        
        fReq.predicate = NSPredicate(format: "city == %@", cityName)
        
        do {
            let emps = try mContext.fetch(fReq)
            return emps
        }catch {
            print("getEmpSortBySalary: Could not fetch ")
        }
        
        return []
    }
    
    func getEmpFilterBySalary(salary : Int) -> [Employee] {
        
        let fReq = Employee.fetchRequest()
        
        fReq.predicate = NSPredicate(format: "salary > %d", salary)
        
        do {
            let emps = try mContext.fetch(fReq)
            return emps
        }catch {
            print("getEmpSortBySalary: Could not fetch ")
        }
        
        return []
    }
    
}
