//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Rita Han on 10/24/21.
//

import UIKit
import AlamofireImage
import Parse
//pick up the image from camera
class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "Posts")//create new object, works like dictionatry
        
        post["caption"] = commentField.text!//
        post["author"] = PFUser.current()!//set the author to the current user
        
        let imageData = imageView.image!.pngData()//save the camera image as pngData
        let file = PFFileObject(name: "image.png", data: imageData!)//a binary object
        
        post["image"] = file
        
        post.saveInBackground{(success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("success!")
            }else{
                print("error")
            }
        }
        
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true //present second screen before finishing up
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera//if camera available, use the actual photo camera
        }else{
            picker.sourceType = .photoLibrary//else choose photo from photo library
        }
        
        present(picker, animated: true, completion: nil)
    }
    // hand back a dictionary containing image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)//rescaled the image
        
        imageView.image = scaledImage//assign it to the image
        
        dismiss(animated: true, completion: nil)
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
