//
//  TabelTableViewController.swift
//  Hw2_B10615045
//
//  Created by shungfu on 2020/4/8.
//  Copyright © 2020 shungfu. All rights reserved.
//

import UIKit

class TabelTableViewController: UITableViewController {
    
    var names = ["Corn","Dairy","Egg","Honey","Molluscs","Nuts","Sugar","Shellfish"]
    var imgs = ["corn_icon","dairy_icon","egg_icon","honey_icon","molluscs_icon","nuts_icon","sugar_icon","shellfish_icon"]
    
    enum EditType {
        case Insert, Delete, None
    }
    var editType = EditType.None
    
    @IBOutlet weak var del_btn: UIButton!
    @IBOutlet weak var ins_btn: UIButton!
    
    var send_name: String? = nil
    var send_img: UIImage? = nil
    
    @IBAction func Delete(_ sender: UIButton) {
        if self.isEditing == false{
            // If not Editting then set as Edit mode
            editType = .Delete
            self.setEditing(true, animated: true)
            del_btn.setTitle("返回", for: .normal)  // Change the btn title as Back
            ins_btn.isEnabled = false   // Disable Insert button
        } else {
            // If IsEditting and is Delete mode, set as not Editting
            if editType == .Delete {
                self.setEditing(false, animated: true)
                del_btn.setTitle("刪除", for: .normal)  // Change the btn title as Delete
                editType = .None
                ins_btn.isEnabled = true   // Enable Insert button
            }
        }
    }
    
    
    @IBAction func Insert(_ sender: UIButton) {
        if self.isEditing == false{
            // If not Editting then set as Edit mode
            editType = .Insert
            self.setEditing(true, animated: true)
            ins_btn.setTitle("返回", for: .normal)  // Change the btn title as Back
            del_btn.isEnabled = false   // Disable Delete button
        }
        else{
            // If IsEditting and is Insert mode, set as not Editting
            if editType == .Insert{
                self.setEditing(false, animated: true)
                ins_btn.setTitle("新增", for: .normal)    // Change the btn title as Insert
                editType = .None
                del_btn.isEnabled = true    // Enable Delete button
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false
        self.setEditing(false, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return names.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.namelabel?.text = names[indexPath.row]
        cell.thumbnail?.image = UIImage(named: imgs[indexPath.row])

        return cell
    }
    
    // The select action
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Set the send data
        send_name = names[indexPath.row]
        send_img = UIImage(named: imgs[indexPath.row])
        performSegue(withIdentifier: "toDetail", sender: self)
        
        // Alert controller
//        let alert = UIAlertController(title: "Row Selected", message: "You select \"\(names[indexPath.row])\"", preferredStyle: .alert)
//        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
//        alert.addAction(action)
//
//        present(alert, animated: true, completion: nil)
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            names.remove(at: indexPath.row)
            imgs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            names.insert(names[indexPath.row], at: indexPath.row)
            imgs.insert(imgs[indexPath.row], at: indexPath.row)
            tableView.insertRows(at: [indexPath], with: .fade)
        //    tableView.reloadData()
        }
    }
    
    // The style of edit mode
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if editType == .Delete{
            return .delete
        }
        return .insert
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        // rearanging names
        let tmp_name = names[fromIndexPath.row]
        names.remove(at: fromIndexPath.row)
        names.insert(tmp_name, at: to.row)
        
        // rearanging image
        let tmp_img = imgs[fromIndexPath.row]
        imgs.remove(at: fromIndexPath.row)
        imgs.insert(tmp_img, at: to.row)
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toDetail"{
            let vc = segue.destination as? DetailViewController
            vc!.receive_name = send_name
            vc!.receive_img = send_img
        }
    }
    

}
