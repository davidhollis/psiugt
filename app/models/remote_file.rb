require 'tempfile'

class RemoteFile < ActiveRecord::Base
  enum role: %i(image genealogy)
  
  def s3_bucket
    "psiugt-org-#{role}"
  end
  
  class << self
    def create_from(io:, role:, suffix: '')
      role = role.to_s
      unless self.roles.keys.include? role
        raise ArgumentError, "role must be one of #{self.roles.keys.inspect}"
      end
      
      instance = new(role: role, s3_key: (SecureRandom.uuid + suffix))
      
      s3 = Aws::S3::Resource.new
      bucket = s3.bucket(instance.s3_bucket)
      uploaded_object = bucket.put_object(
        body: io,
        acl: 'public-read',
        key: instance.s3_key
      )
      
      if uploaded_object
        instance.url = uploaded_object.public_url
        instance.save
        instance
      else
        nil
      end
    end
    
    def create_from_temp_file(role:, suffix: '', &block)
      instance = nil
      Tempfile.open('remote_file') do |tmp_file|
        block[tmp_file]
        tmp_file.rewind
        instance = create_from(io: tmp_file, role: role, suffix: suffix)
      end
      
      instance
    end
  end
end
