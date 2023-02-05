avatar_files_path = Dir[Rails.root.join('db/seeds/avatars/*.jpeg')]
avatar_background_files_path = Dir[Rails.root.join('db/seeds/avatar_backgrounds/*.jpeg')]
posts_files_path = Dir[Rails.root.join('db/seeds/posts/*.jpeg')]

def create_users
  puts "Creating users"
  user = User.find_by(email: "b@b.com")
  if user.nil?
    user = User.new(email: "b@b.com", password: "manager", password_confirmation: "manager", full_name: "John Smith",
                    bio: "Sample Account", username: "johnsmith88")
    user.skip_confirmation!
    user.save!
  end
  return unless User.all.count < 2

  24.times do
    # pass = Faker::Internet.base64
    pass = "manager"
    name = Faker::Name.name
    uname = name.gsub(/\s+|\.+/, "").downcase + rand(0..99).to_s
    e = uname + ["@yahoo.com", "@gmail.com", "@example.com"].sample
    user = User.new(email: e, password: pass, password_confirmation: pass, full_name: name,
                    bio: Faker::Quote.jack_handey[0, 139], username: uname)
    user.skip_confirmation!
    user.save!
  end
end

def download_images
  puts "Downloading images"
  client = Pexels::Client.new(Rails.application.credentials.dig(:pexels, :api_key))

  # Download 15 pictures for avatar
  response = client.photos.search('Portrait', size: :medium)
  response.each do |photo|
    url = photo.src["medium"]
    Down.download(url, destination: Rails.root.join('db/seeds/avatars/'))
  end

  # Download 15 pictures for avatar background
  response = client.photos.search('Background', size: :medium)
  response.each do |photo|
    url = photo.src["landscape"]
    Down.download(url, destination: Rails.root.join('db/seeds/avatar_backgrounds/'))
  end

  # Download 160 pictures for posts
  2.times do |i|
    response = client.photos.curated(page: i + 1, per_page: 80)
    response.each do |photo|
      url = photo.src["large"]
      Down.download(url, destination: Rails.root.join('db/seeds/posts/'))
    end
  end
end

if (avatar_files_path.size <= 4) || (avatar_background_files_path.size <= 4) || (posts_files_path.size <= 20)
  # Download avatar, avatar background and images for posts from pexels.com
  download_images
end

# download_images

# Create Users
create_users

# Get the list of files
avatar_files_path = Dir[Rails.root.join('db/seeds/avatars/*.jpeg')]
avatar_background_files_path = Dir[Rails.root.join('db/seeds/avatar_backgrounds/*.jpeg')]
posts_files_path = Dir[Rails.root.join('db/seeds/posts/*.jpeg')]

puts "Adding avatar, bg pic and 8 posts for each user"
User.find_each do |user|
  # Attach avatar and avatar_background for each user
  user.avatar.attach(io: File.open(avatar_files_path.sample), filename: "#{Faker::Internet.base64}.jpeg")
  user.avatar_background.attach(io: File.open(avatar_background_files_path.sample),
                                filename: "#{Faker::Internet.base64}.jpeg")
  user.save!

  # Create 8 posts for each user
  8.times do
    post = user.posts.build(caption: Faker::Quote.most_interesting_man_in_the_world,
                            location: Faker::Address.city(options: { with_state: true }))
    post.image.attach(io: File.open(posts_files_path.sample), filename: "#{Faker::Internet.base64}.jpeg")
    post.save
  end
end

# Create comments

def random_user_id
  User.offset(rand(User.count)).first.id
end

puts "Adding comments to each post"
Post.find_each do |post|
  rand(1..5).times do
    # create top level comment
    post.comments.create(body: Faker::Quote.matz, user_id: random_user_id)
  end

  rand(1..5).times do
    # response comment to top level comment
    post.comments.create(body: Faker::Quote.matz, user_id: random_user_id, parent_id: post.comments.pluck(:id).sample)
  end
end

# Create likes
puts "Adding likes to each post and comment"
User.find_each do |u|
  Post.find_each do |p|
    Like.create(user: u, likeable: p) if Random.rand > 0.6
  end

  Comment.find_each do |c|
    Like.create(user: u, likeable: c) if Random.rand > 0.6
  end
end

# Create Followers
puts "Creating followers for each user"
User.find_each do |u|
  14.times do
    followee_user = User.find(random_user_id)
    unless u.follows?(followee_user)
      Relationship.create(follower: u, followee: followee_user)
      # puts u.full_name + " follows " + followee_user.full_name
    end
  end
end

# Randomize every post's created date
Post.find_each do |p|
  p.created_at = p.created_at - rand(10..90).days
  p.save
end

# Randomize every comment's created date
Comment.find_each do |c|
  c.created_at = c.created_at - rand(1..10).days
  c.save
end
