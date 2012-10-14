class User < ActiveRecord::Base
  include Logging

  has_and_belongs_to_many :feeds, order: 'name ASC'

  def self.find_or_create_from_auth_hash(auth)
    existing_user = self.find_by_uid(auth['uid'])
    if existing_user
      logger.info("Found user #{existing_user} for #{auth.inspect}")
      return existing_user
    end

    new_user = self.new
    new_user.uid = auth['uid']
    new_user.provider = auth['provider']

    info = auth['info'] || { }
    new_user.name = info['name'] || new_user.uid
    new_user.email = info['email'] || new_user.email
    new_user.save!

    logger.info("Created new user #{new_user} for #{auth.inspect}")
    NewUserSetup.setup(new_user)
    new_user
  end

  def anon?
    false
  end

  def to_s
    "User[#{self.uid}/#{self.name}]"
  end
end
