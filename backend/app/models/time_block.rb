class TimeBlock < ApplicationRecord

  scope :after, ->(from_date) { where('start > ?', from_date) }
  scope :before, ->(to_date) { where('end < ?', to_date) }
  scope :user_id, ->(id) { where('user_id = ?', id) }

  def self.search(params)
    blocks = where(nil)
    params.each do |key, value|
      blocks = blocks.public_send(key, value) if value.present?
    end
    blocks.order('start ASC')
  end
end
