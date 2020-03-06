class Artifact < ApplicationRecord
	before_save :upload_to_s3
  attr_accessor :upload
  belongs_to :project
  
  MAX_FILESIZE = 10.megabytes
  validates_presence_of :name, :upload
  validates_uniqueness_of :name
  
  validate :uploaded_file_size
  
  private
  
		def uploaded_file_size
			if upload
				errors.add(:upload, "File size must be less than #{self.class::MAX_FILESIZE}") unless upload.size <= self.class::MAX_FILESIZE
			end
		end
		
		def upload_to_s3
			s3 = Aws::S3::Resource.new(region: 'us-west-2')
			tenant_name = Tenant.find(Thread.current[:tenant_id]).name
			obj = s3.bucket(Rails.application.credentials.aws[:s3_bucket_name]).object("#{tenant_name}/#{upload.original_filename}")
			obj.upload_file(upload.path, acl:'public-read')
			self.key = obj.public_url
		end
end