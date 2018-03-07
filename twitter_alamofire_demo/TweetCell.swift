//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screen_nameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet var retweetButton: UIButton!
    @IBOutlet var favoriteButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            retweetCountLabel.text = String(describing: tweet.retweetCount)
            favoriteCountLabel.text = String(describing: tweet.favoriteCount)
            nameLabel.text = tweet.user.name
            screen_nameLabel.text = tweet.user.screenName
            createdAtLabel.text = tweet.createdAtString
            profileImage.af_setImage(withURL: tweet.user.profileImageURLHTTPS!)
        }
    }
    @IBAction func onRetweet(_ sender: Any) {
        if (tweet.retweeted == false) {
            tweet.retweeted = true
            tweet.retweetCount += 1
        }
        else if (tweet.retweeted == true) {
            tweet.retweeted = false
            tweet.retweetCount -= 1
        }
        APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
            }
        }
        refreshData()
    }
    
    func refreshData() {
        if (tweet.favorited == true) {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
        }
        else if (tweet.favorited == false) {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal)
        }
        if (tweet.retweeted == true) {
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
        }
        else if (tweet.retweeted == false) {
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
        }
        tweetTextLabel.text = tweet.text
        retweetCountLabel.text = String(describing: tweet.retweetCount)
        favoriteCountLabel.text = String(describing: tweet.favoriteCount)
        nameLabel.text = tweet.user.name
        screen_nameLabel.text = tweet.user.screenName
        createdAtLabel.text = tweet.createdAtString
        profileImage.af_setImage(withURL: tweet.user.profileImageURLHTTPS!)
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        if (tweet.favorited == false) {
            tweet.favorited = true
            tweet.favoriteCount += 1
        }
        else if (tweet.favorited == true) {
            tweet.favorited = false
            tweet.favoriteCount -= 1
        }
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
            }
        }
        refreshData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
