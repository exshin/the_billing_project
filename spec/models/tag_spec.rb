# == Schema Information
#
# Table name: tags
#
#  id                 :bigint(8)        not null, primary key
#  name               :string
#  tag_reference_type :string
#  tag_reference_id   :bigint(8)
#

require 'rails_helper'

RSpec.describe Tag, type: :model do
  ## Nothing to test in this model
end
