# class News < ActiveRecord::Base
#   structure do
#     title        :string,   validates: [:presence, {length: { minimum: 5 }}]
#     content      :text,     validates: [:presence]
#     published_at :datetime, validates: [:presence], default: Time.zone.now

#     timestamps
#   end

#   default_scope order('created_at DESC')

#   scope :published, lambda { where(['published_at <= ?', Time.zone.now]) }

#   set_callback :initialize, :after, lambda { self.published_at ||= Time.zone.now }
# end
