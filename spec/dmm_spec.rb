require 'spec_helper'

describe Dmm do
  it { should respond_to(:new) }

  describe 'new' do
    it 'returns Dmm::Client instance' do
      subject.new.should be_a_kind_of Dmm::Client
    end
  end

  describe 'const_missing' do
    it 'should be "DMM.co.jp" when call DMM::R18' do
      Dmm::R18.should == 'DMM.co.jp'
    end

    it 'should be "DMM.com" when call DMM::COM' do
      Dmm::COM.should == 'DMM.com'
    end

    it 'should raise NameError when call undefined constant "Foo"' do
      lambda{Dmm::Foo}.should raise_error NameError
    end
  end
end