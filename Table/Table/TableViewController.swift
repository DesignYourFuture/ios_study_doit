//
//  TableViewController.swift
//  Table
//
//  Created by Hamlit Jason on 2021/02/25.
//

import UIKit

    var items = ["책 구매", "철수와 약속", "스터디 준비하기"] // 여기서 또 하나의 중요한 개념!! 다른 스위프트 파일에서도 참조하려면 클래스 밖에다가 선언해두어야 한다.
    var itemsImageFile = ["cart.png","clock.png","pencil.png"]

class TableViewController: UITableViewController {

    @IBOutlet var tvListView: UITableView!
    
 
    /* 참고
     뷰 디드로드 - 뷰가 로드 되었을 떄, 즉, 뷰가 생성될 때 한번만 호출된다.
     뷰 윌어피어 - 뷰가 노출될 준비가 끝났을 때 ,뷰가 노출될 때마다
     뷰 디드어피어 - 뷰가 완전히 보인 후 호출되는 함수, 뷰가 완전히 보인 후 호출된다.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in itemsImageFile {
            let image = UIImage(named: i)
            imageArray.append(image)
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem // 메인 스토리보드에 따로 추가하지 않아도 된다. 왼쪽 바버튼 아이템 사용하는 코드이다.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tvListView.reloadData() // 테이블 뷰를 다시 불러온다. 즉, 테이블뷰에 변경사항이 있으면 반영한다.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 //보통은 테이블안에 섹션이 한개이므로 일단 1로한다.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count // 섹션당 열의 수는 아이템의 개수이므로 아이템의 갯수를 리턴한다.
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        cell.textLabel?.text = items[(indexPath as NSIndexPath).row]
        cell.imageView?.image = UIImage(named: itemsImageFile[(indexPath as NSIndexPath).row])
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 옆으로 밀었을때 삭제하는 코드
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: (indexPath as NSIndexPath).row)
            itemsImageFile.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
        }    
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제" // 왼쪽으로 밀었을때 딜리트를 한글로 삭제라고 뜨게 만드는 코드
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        // 목록을 드래그하여 위치를 바꾸는 함수이다.
        
        let itemToMove = items[(fromIndexPath as NSIndexPath).row] // 이동할 아이템의 위치
        let itemImageToMove = itemsImageFile[(fromIndexPath as NSIndexPath).row] // 이동할 아이템의 이미지
        items.remove(at: (fromIndexPath as NSIndexPath).row) // 이동할 아이템을 삭제 - 이때!!! 뒤의 아이템의 인덱스는 재정렬된다.
        itemsImageFile.remove(at: (fromIndexPath as NSIndexPath).row) // 이동할 이미지 삭제 - 이때!!! 뒤의 이미지의 인덱스는 재정렬된다.
        items.insert(itemToMove, at: (to as NSIndexPath).row) // 삭제된 아이템을 삽입 - 이떄!! 삽입 후 인덱스는 재정렬된다.
        itemsImageFile.insert(itemImageToMove, at: (to as NSIndexPath).row) // 삭제된 이미지 삽입 - 이때!! 삽입 후 인덱스는 재정렬된다.
        
        
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        NSLog("asd")
        if segue.identifier == "sgDetail" {
            let cell = sender as! UITableViewCell // 센더가 any 타입이라서 캐스팅해서 cell을 선언하고
            let indexPath = self.tvListView.indexPath(for: cell) //
            let detailView = segue.destination as! DetailViewController
            detailView.receiveItem(items[((indexPath! as NSIndexPath).row)])
        }
    }

}
	
