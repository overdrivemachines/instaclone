namespace :counters do
  # Preventing N+1 queries by counting associated objects in the query can help,
  # but caching counters is an even faster way to show counters.
  desc "Update Cached Counters"
  # We want access to ActiveRecord models so we have to load in the environment
  task update: :environment do
    Post.find_each do |post|
      Post.reset_counters(post.id, :comments)
    end
  end
end
