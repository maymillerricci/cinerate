class Review < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates_format_of :user_email, with: VALID_EMAIL_REGEX, message: "is not a valid email address"
  validates_numericality_of :rating, greater_than_or_equal_to: 0, less_than_or_equal_to: 10
end
