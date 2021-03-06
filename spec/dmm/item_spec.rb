# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Dmm::Item do
  context 'with valid response' do
    before(:all) do
      @items = sample_response.items
    end

    context 'with first item' do
      subject { @items.first }

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