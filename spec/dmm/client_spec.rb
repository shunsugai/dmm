require 'spec_helper'

describe Dmm::Client do

  context 'initialize with correct configuration value' do

    subject do
      Dmm::Client.new(:api_id => ENV['API_ID'], :affiliate_id => ENV['AFFILIATE_ID'])
    end

    describe 'initialization' do
      its(:api_id) { should eq ENV['API_ID'] }
      its(:affiliate_id) { should eq ENV['AFFILIATE_ID'] }
    end

    describe '#params' do
      it 'should return collect params' do
        params = {
          :api_id       => ENV['API_ID'],
          :affiliate_id => ENV['AFFILIATE_ID'],
          :operation    => 'ItemList',
          :version      => Dmm::API_VERSION,
          :timestamp    => Time.now.to_s,
          :site         => Dmm::R18,
          :keyword      => 'hogehoge'
        }
        subject.send(:params, {:keyword => 'hogehoge'}).should eq params
      end
    end
  end

  context 'initialize with wrong configuration value' do

    share_examples_for '#item_list with wrong arguments' do
      it { proc{subject.item_list}.should raise_error Dmm::Error }
    end

    share_examples_for '#error_message with wrong api_id' do
      it 'should equal "LoginError: No existing account (login)"' do
        res = subject.get('/', subject.send(:params))
        subject.send(:error_message, res).should eq 'LoginError: No existing account (login)'
      end
    end

    context 'call API with wrong api_id' do
      subject { Dmm.new(:api_id => 'foo', :affiliate_id => ENV['AFFILIATE_ID']) }

      describe '#item_list' do
        it_should_behave_like '#item_list with wrong arguments'
      end

      describe '#error_message' do
        it_should_behave_like '#error_message with wrong api_id'
      end
    end

    context 'call API with wrong affiliate_id' do
      subject { Dmm.new(:api_id => ENV['API_ID'], :affiliate_id => 'foo') }

      describe '#item_list' do
        it_should_behave_like '#item_list with wrong arguments'
      end

      describe '#error_message' do
        it 'should equal "RequestError: Parameter not found (affiliate_id)"' do
          res = subject.get('/', subject.send(:params))
          subject.send(:error_message, res).should eq 'RequestError: Parameter not found (affiliate_id)'
        end
      end
    end

    context 'call API with wrong api_id and affiliate_id' do
      subject { Dmm.new(:api_id => 'foo', :affiliate_id => 'bar') }

      describe '#item_list' do
        it_should_behave_like '#item_list with wrong arguments'
      end

      describe '#error_message' do
        it_should_behave_like '#error_message with wrong api_id'
      end
    end
  end
end