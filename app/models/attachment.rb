class Attachment < ActiveRecord::Base
  belongs_to :issue
  mount_uploader :file, AttachmentUploader
end
