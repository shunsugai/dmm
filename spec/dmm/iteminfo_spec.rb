# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Dmm::Iteminfo do
  context 'with valid response' do
    before do
      request_url = 'http://affiliate-api.dmm.com/?api_id=API_ID&affiliate_id=AFFILIATE_ID&operation=ItemList&version=2.00&timestamp='+Time.now.to_s.gsub(/\s/, '+')+'&site=DMM.co.jp&keyword=%B5%F0%C6%FD'
      stub_request(:get, request_url).to_return(:status => 200, :body => fixture('sample2.xml'))
      client = Dmm.new(:api_id => 'API_ID', :affiliate_id => 'AFFILIATE_ID')
      response = client.item_list(:keyword => '巨乳')
      @results = response.items
    end

    context 'with first item' do
      subject { @results.first.iteminfo }

      its(:keyword) { should eq ['エステ', 'ナンパ', '人妻', '痴女', '巨乳', '独占配信', 'ハイビジョン'] }
      its(:maker)   { should eq '変態紳士倶楽部' }
      its(:label)   { should eq '変態紳士倶楽部' }

      if RUBY_VERSION >= '1.9'
        describe 'respond_to_missing?' do
          %w(series maker label keyword actress director author).each do |method|
            it "should be ture with argument #{method.to_sym}" do
              subject.respond_to_missing?(method.to_sym).should be_true
            end
          end
        end
      end

      if RUBY_VERSION < '1.9'
        describe 'respond_to_missing?' do
          %w(series maker label keyword actress director author).each do |method|
            it "should be ture with argument #{method.to_sym}" do
              subject.respond_to?(method.to_sym).should be_true
            end
          end
        end
      end
    end
  end
end