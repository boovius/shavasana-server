class User < ActiveRecord::Base
  has_many :activities
end

class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :doings
end

class Doing < ActiveRecord::Base
  belongs_to :activity

  after_save :update_counts

  def update_counts
    beginning_of_week  = Time.now - (Time.now.wday - 1).days
    beginning_of_month = Time.now - (Time.now.day - 1).days

    activity.weekly  = activity
                        .doings
                        .where('created_at > ?', beginning_of_week)
                        .count

    activity.monthly = activity
                        .doings
                        .where('created_at > ?', beginning_of_month)
                        .count

    activity.done_last_at = activity.doings.last.created_at

    activity.save
  end
end
