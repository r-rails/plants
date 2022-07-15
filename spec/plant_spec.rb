require 'rails_helper'

RSpec.describe Plant, :type => :model do
  it "is valid with valied attributes"
  it "is not valid without a name"
  it "is not valid without a record_id"
  it "is not valid without a blob_id"
  it "is not valid without a created_at date"
  it "is not valid without an index for blob_id for index_active_storage_attachments_on_blob_id"
  it "is not valid without an index for index_active_storage_attachements_uniqueness"
end