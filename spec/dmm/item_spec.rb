# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Dmm::Item do
  context 'with valid response' do
    before(:all) do
      request_url = 'http://affiliate-api.dmm.com/?api_id=API_ID&affiliate_id=AFFILIATE_ID&operation=ItemList&version=2.00&timestamp='+Time.now.to_s.gsub(/\s/, '+')+'&site=DMM.co.jp&keyword=%B5%F0%C6%FD'
      stub_request(:get, request_url).to_return(:status => 200, :body => fixture('sample2.xml'))
      client = Dmm.new(:api_id => 'API_ID', :affiliate_id => 'AFFILIATE_ID')
      response = client.item_list(:keyword => '巨乳')
      @results = response.items
    end

    context 'with first item' do
      subject { @results.first }

      its(:service_name)     { should eq '動画' }
      its(:floor_name)       { should eq 'ビデオ' }
      its(:category_name)    { should eq 'ビデオ (動画)' }
      its(:content_id)       { should eq 'club00025' }
      its(:product_id)       { should eq 'club00025' }
      its(:title)            { should eq '東京都港区白金セレブ人妻ナンパエステ' }
      its(:url)              { should eq 'http://www.dmm.co.jp/digital/videoa/-/detail/=/cid=club00025/' }
      its(:affiliate_url)    { should eq 'http://www.dmm.co.jp/digital/videoa/-/detail/=/cid=club00025/AFFILIATE_ID' }
      its(:image_url)        { should eq Hash[:list=>"http://pics.dmm.co.jp/digital/video/club00025/club00025pt.jpg", :small=>"http://pics.dmm.co.jp/digital/video/club00025/club00025ps.jpg", :large=>"http://pics.dmm.co.jp/digital/video/club00025/club00025pl.jpg"] }
      its(:sample_image_url) { should eq ["http://pics.dmm.co.jp/digital/video/club00025/club00025-1.jpg", "http://pics.dmm.co.jp/digital/video/club00025/club00025-2.jpg", "http://pics.dmm.co.jp/digital/video/club00025/club00025-3.jpg"] }
      its(:date)             { should eq '2013-01-26 10:00:11'}
      its(:prices)           { should be_kind_of Dmm::Price }
      its(:iteminfo)         { should be_kind_of Dmm::Iteminfo }

      describe 'method_missing' do
        it 'delegates to Dmm::Price' do
          subject.min_price.should eq 500
        end

        it 'delegates to Dmm::Iteminfo' do
          subject.maker.should eq '変態紳士倶楽部'
        end
      end
    end
  end
end