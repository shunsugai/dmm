require 'spec_helper'

describe Dmm::Response do
  subject { Dmm.new(:api_id => ENV['API_ID'], :affiliate_id => ENV['AFFILIATE_ID']).item_list }

  describe '#respond_to?' do
    it 'should be true with argument :items' do
      subject.respond_to?(:items).should be_true
    end
    it 'should be true with argument :result_count' do
      subject.respond_to?(:result_count).should be_true
    end
    it 'should be true with argument :total_count' do
      subject.respond_to?(:total_count).should be_true
    end
    it 'should be true with argument :first_position' do
      subject.respond_to?(:first_position).should be_true
    end
    it 'should be true with argument :result' do
      subject.respond_to?(:result).should be_true
    end
    it 'should not be true with argument :hogehoge' do
      subject.respond_to?(:hogehoge).should_not be_true
    end
  end

  describe 'Object#method' do
    it 'should be return instance of Method' do
      subject.method(:items).should be_kind_of Method
    end

    it 'should raise NameError argument with undefined method in Dmm::Result' do
      lambda{subject.method(:fooooo)}.should raise_error NameError
    end
  end
end
