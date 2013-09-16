require 'spec_helper'

describe Dmm::Response do
  context 'with valid response' do
    before(:all) do
      @response = sample_response
    end

    subject { @response }

    its(:result_count)   { should eq 20 }
    its(:total_count)    { should eq 162539 }
    its(:first_position) { should eq 1 }
  end
end