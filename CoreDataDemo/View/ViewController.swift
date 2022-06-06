//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Shridevi Sawant on 28/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    // Strong reference of ViewModel
    let empVM = EmployeeVM()

    @IBOutlet weak var tbl: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("Home Dir: \(NSHomeDirectory())")
        
        
        empVM.getEmp()
        
        print("Total emps: \(empVM.empList.count)")
        
        tbl.dataSource = self
        tbl.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addBtnSelected))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteBtnSelected))
        
        navigationItem.title = "CapGemini"
    }

    @IBAction func filterClicked(_ sender: Any) {
        
        // filter emp by city name
        
        //empList = getEmpFilterByCity(cityName: "Bangalore")
        empVM.filterEmpBySalary(minSalary: 1000)
        tbl.reloadData()
    }
    @IBAction func sortClicked(_ sender: Any) {
        
        //empList = getEmpSortByName()
        empVM.sortEmpBySal()
        tbl.reloadData()
        
    }
    @objc func deleteBtnSelected(){
        // delete all employees
        
        for emp in empVM.empList {
            empVM.deleteEmp(empToDelete: emp)
        }
        empVM.empList = []
        tbl.reloadData()
    }

    @objc func addBtnSelected(){
        print("Add selected")
        // add employee
        
        // navigate to next screen
        // alertController
        
        let alertVC = UIAlertController(title: "Add Employee", message: nil, preferredStyle: .alert)
        
        alertVC.addTextField { tf in
            tf.placeholder = "Employee Name"
            tf.textColor = .blue
        }
        
        alertVC.addTextField { tf in
            tf.placeholder = "Employee ID"
            tf.textColor = .blue
        }
        
        alertVC.addTextField { tf in
            tf.placeholder = "Employee Salary"
            tf.textColor = .blue
        }
        
        alertVC.addTextField { tf in
            tf.placeholder = "Employee City"
            tf.textColor = .blue
        }
        
        let okAction = UIAlertAction(title: "ADD", style: .default) { _ in
            // add emp to db
            let empName = alertVC.textFields?[0].text ?? ""
            let empID = alertVC.textFields?[1].text ?? ""
            let empSal = alertVC.textFields?[2].text ?? ""
            let empCity = alertVC.textFields?[3].text ?? ""
            
            let id = Int(empID) ?? 0
            let sal = Int(empSal) ?? 0
            
            self.empVM.addEmp(empName: empName, id: id, empCity: empCity, sal: sal)
            self.empVM.getEmp()
            
            self.tbl.reloadData() // table refreshed
        }
        
        alertVC.addAction(okAction)
        present(alertVC, animated: false, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empVM.empList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // get cell, bind data, return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "empCell", for: indexPath) as! EmployeeCell
        
        let emp = empVM.empList[indexPath.row]
        
        cell.nameL.text = emp.name
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd/MM/yyyy"
        let jDate = formatter.string(from: emp.joining_date ?? Date())
        
        cell.cityL.text = jDate
        cell.idL.text = "\(emp.emp_id)"
        cell.salaryL.text = "\(emp.salary)"
        
        return cell
    }
    
    
}

extension ViewController : UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        // delete emp
//        let emp = empList[indexPath.row]
//
//        deleteEmp(emp: emp) // deleted from db
//        empList.remove(at: indexPath.row)
//
//        tbl.deleteRows(at: [indexPath], with: .automatic)
//    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    
       
        
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
        
            let editAction = UIAction(title: "Edit", image: nil, identifier: nil, discoverabilityTitle: nil) { _ in
                
                let emp = self.empVM.empList[indexPath.row]
                
                print("Editing \(emp.name ?? "")")
                
                emp.salary = 10000
                
                
            }
            
            let deleteAction = UIAction(title: "Delete", image: nil, identifier: nil, discoverabilityTitle: nil) { _ in
                let emp = self.empVM.empList[indexPath.row]
                
                print("deleting \(self.empVM.empList[indexPath.row].name ?? "")")
                
                self.empVM.deleteEmp(empToDelete: emp)
                self.empVM.empList.remove(at: indexPath.row)
                //
                self.tbl.deleteRows(at: [indexPath], with: .automatic)
                
                
            }
            
            return UIMenu(title: "Select action", image: nil, identifier: nil, options: .displayInline, children: [editAction, deleteAction])
        }
    }
    
}
