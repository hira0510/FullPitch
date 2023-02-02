//
//  RecordViewController.swift
//  FullPitch
//
//  Created by Hira on 2021/10/4.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet weak var mTableView: UITableView!
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setExtraCellLineHidden()
    }
    
    private func setupUI() {
        mTableView.delegate = self
        mTableView.dataSource = self
        mTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        mTableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    private func setExtraCellLineHidden() {
        let view = UIView()
        view.backgroundColor = .clear
        mTableView.tableFooterView = view
    }
}

extension RecordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefaults.standard.stringArray(forKey: "Record")?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        guard let model = UserDefaults.standard.stringArray(forKey: "Record"), model.count > indexPath.row else { return cell }
        cell.textLabel?.text = model[indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 0.6871806325, green: 0.8522377281, blue: 1, alpha: 1)
        cell.textLabel?.numberOfLines = 3
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1971694012)
        return cell
    }
}
