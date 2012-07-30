require 'spec_helper'

describe Phone do

  subject { create :phone }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
end
