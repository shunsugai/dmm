# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Dmm::Price do
  context 'with valid response' do
    before do
      request_url = 'http://affiliate-api.dmm.com/?api_id=API_ID&affiliate_id=AFFILIATE_ID&operation=ItemList&version=2.00&timestamp='+Time.now.to_s.gsub(/\s/, '+')+'&site=DMM.co.jp&keyword=%B5%F0%C6%FD'
      stub_request(:get, request_url).to_return(:status => 200, :body => fixture('sample2.xml'))
      client = Dmm.new(:api_id => 'API_ID', :affiliate_id => 'AFFILIATE_ID')
      response = client.item_list(:keyword => '巨乳')
      @results = response.items
    end

    subject { @results.first.prices }

    its(:min_price)      { should eq 500 }
    its(:deliveries)     { should eq [{:type=>"stream", :price=>"500"}, {:type=>"download", :price=>"980"}, {:type=>"hd", :price=>"1480"}, {:type=>"androiddl", :price=>"980"}] }
    its(:delivery_types) { should eq ['stream', 'download', 'hd', 'androiddl'] }

    describe 'method_missing' do
      its(:price_stream)    { should eq 500 }
      its(:price_download)  { should eq 980 }
      its(:price_hd)        { should eq 1480 }
      its(:price_androiddl) { should eq 980 }
      its(:price_toaster)   { should be_nil }
    end

    if RUBY_VERSION >= '1.9'
      describe 'respond_to_missing?' do
        %w(price_stream price_download price_hd price_androiddl).each do |method|
          it "should be true with argument #{method}" do
            subject.respond_to_missing?(method.to_sym).should be_true
          end
        end

        it 'should be true with non-existent price type' do
          subject.respond_to_missing?(:price_toaster).should be_true
        end
      end
    end

    if RUBY_VERSION < '1.9'
      describe 'respond_to?' do
        %w(price_stream price_download price_hd price_androiddl).each do |method|
          it "should be true with argument #{method}" do
            subject.respond_to?(method.to_sym).should be_true
          end
        end

        it 'should be true with non-existent price type' do
          subject.respond_to?(:price_toaster).should be_true
        end
      end
    end
  end
end