//
//  InstafeedViewController.swift
//  Instagram
//
//  Created by Shakeel Daswani on 3/14/16.
//  Copyright © 2016 shakeeld. All rights reserved.
//

import UIKit
import Parse

class InstafeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    var posts : [PFObject]?
    let vc = UIImagePickerController()
    
    
    @IBOutlet weak var instaImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    

        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
        showPosts()
       
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
       
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func showPosts() {
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                // do something with the array of object returned by the call
                self.posts = posts
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return posts?.count ?? 0
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("instaCell", forIndexPath: indexPath) as! InstaCellTableViewCell
        let instagramPost = posts![indexPath.row]
        
        cell.instagramPost = instagramPost
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    



@IBAction func onLogoutButton(sender: AnyObject) {
    PFUser.logOut()
    NSNotificationCenter.defaultCenter().postNotificationName("userDidLogoutNotification", object: nil)
}
    
    
    @IBAction func oncaptureButton(sender: AnyObject) {
        
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            
            
            
    
            
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
     func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image) // PFFile column type
        post["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackgroundWithBlock(completion)
    }
    
    

    
    
    
    func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }







    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
