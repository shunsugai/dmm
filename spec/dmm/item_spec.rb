# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Dmm::Item do

  subject do
    Dmm::Item.new({:service_name=>"動画",
            :floor_name=>"ビデオ",
            :category_name=>"ビデオ (動画)",
            :content_id=>"118mas00093",
            :product_id=>"118mas00093",
            :title=>"絶対的美少女、お貸しします。 ACT.25",
            :URL=>
             "http://www.dmm.co.jp/digital/videoa/-/detail/=/cid=118mas00093/",
            :affiliateURL=>
             "http://www.dmm.co.jp/digital/videoa/-/detail/=/cid=118mas00093/#{ENV['AFFILIATE_ID']}",
            :imageURL=>
             {:list=>
               "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093pt.jpg",
              :small=>
               "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093ps.jpg",
              :large=>
               "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093pl.jpg"},
            :sampleImageURL=>
             {:sample_s=>
               {:image=>
                 ["http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093-1.jpg",
                  "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093-2.jpg",
                  "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093-3.jpg",
                  "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093-4.jpg",
                  "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093-5.jpg",
                  "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093-6.jpg",
                  "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093-7.jpg",
                  "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093-8.jpg",
                  "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093-9.jpg",
                  "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093-10.jpg"]}},
            :prices=>
             {:price=>"1980~",
              :deliveries=>
               {:delivery=>
                 [{:type=>"stream", :price=>"1980"},
                  {:type=>"download", :price=>"1980"}]}},
            :date=>"2013-01-12 10:01:00",
            :iteminfo=>
             {:keyword=>
               [{:name=>"顔射", :id=>"5023"},
                {:name=>"単体作品", :id=>"4025"},
                {:name=>"美少女", :id=>"1027"}],
              :series=>{:name=>"絶対的美少女、お貸しします。", :id=>"79983"},
              :maker=>{:name=>"プレステージ", :id=>"40136"},
              :actress=>
               [{:name=>"あやみ旬果", :id=>"1016835"},
                {:name=>"あやみしゅんか", :id=>"1016835_ruby"},
                {:name=>"av", :id=>"1016835_classify"}],
              :label=>{:name=>"ます。", :id=>"20940"}}})
  end

  its(:service_name) { should eq '動画' }
  its(:floor_name) { should eq 'ビデオ' }
  its(:category_name) { should eq 'ビデオ (動画)' }
  its(:content_id) { should eq '118mas00093' }
  its(:product_id) { should eq '118mas00093' }
  its(:title) { should eq '絶対的美少女、お貸しします。 ACT.25' }
  its(:url) { should eq 'http://www.dmm.co.jp/digital/videoa/-/detail/=/cid=118mas00093/' }
  its(:affiliateURL) { should eq "http://www.dmm.co.jp/digital/videoa/-/detail/=/cid=118mas00093/#{ENV['AFFILIATE_ID']}" }
  its(:sample_image_url) { should eq ["http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093-1.jpg",
                                      "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093-2.jpg",
                                      "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093-3.jpg",
                                      "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093-4.jpg",
                                      "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093-5.jpg",
                                      "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093-6.jpg",
                                      "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093-7.jpg",
                                      "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093-8.jpg",
                                      "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093-9.jpg",
                                      "http://pics.dmm.co.jp/digital/video/118mas00093/118mas00093-10.jpg"] }
  its(:prices) { should be_a_kind_of Dmm::Price }
  its(:iteminfo) { should be_a_kind_of Dmm::Iteminfo }

  its(:keyword) { should eq ['顔射', '単体作品', '美少女'] }
  its(:price) { should eq '1980~' }
  its(:min_price) { should eq 1980 }
  its(:price_stream) { should eq 1980 }
  its(:price_download) { should eq 1980 }
  its(:price_androiddl) { should be_nil }
  its(:deliveries) { should eq [{:type=>"stream", :price=>"1980"},{:type=>"download", :price=>"1980"}] }
  its(:delivery_types) { should eq ['stream', 'download'] }
end